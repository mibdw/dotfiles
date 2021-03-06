import os
import iwlib
import subprocess

from typing import List

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "kitty"
browser = "firefox"

keys = [
    Key([mod], "j", lazy.layout.next(), desc="Move focus to next"),
    Key([mod], "Down", lazy.layout.next(), desc="Move focus to next"),
    Key([mod], "k", lazy.layout.previous(), desc="Move focus to previous"),
    Key([mod], "Up", lazy.layout.previous(), desc="Move focus to previous"),

    Key([mod, "shift"], "j", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_right(),
        desc="Move window to the right"),

    Key([mod], "h", lazy.screen.prev_group(), desc="Move to previous group"),
    Key([mod], "Left", lazy.screen.prev_group(), desc="Move to previous group"),
    Key([mod], "l", lazy.screen.next_group(), desc="Move to next group"),
    Key([mod], "Right", lazy.screen.next_group(), desc="Move to next group"),
    Key([mod], "i", lazy.screen.toggle_group(), desc="Toggle latest group"),

    Key([mod], "u", 
        lazy.layout.grow(),
        desc="Grow master window"
    ),
    Key([mod], "y", 
        lazy.layout.shrink(),
        desc="Shrink master window"
    ),
    Key([mod], "BackSpace", 
        lazy.layout.flip(),
        desc="Flip master window"
    ),

    Key([mod, "shift"], "z", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod], "q", lazy.restart(), desc="Restart Qtile, preserve windows"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "semicolon", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    Key([mod, "shift"], "o", 
        lazy.spawn(["sh", "-c", "maim -s -u | xclip -selection clipboard -t image/png"])
        , desc="Copy screenshot selection to clipboard"),

    Key([mod, "shift"], "n", 
        lazy.spawn(["sh", "-c", "dunstctl close-all"])
        , desc="Close all Dunst notifications"),

    Key([mod], "n", 
        lazy.spawn(["sh", "-c", "dunstctl history-pop"])
        , desc="Pop last Dunst notifications"),
    Key(
        [mod], "x",
        lazy.spawn(["sh", "-c", "nitrogen --force-setter=xinerama --head=0 --set-zoom-fill --random & nitrogen --force-setter=xinerama --head=1 --set-zoom-fill --random &"])
    ),

    Key(
        [], "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    ),
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("pactl -- set-sink-volume 0 +2%")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("pactl -- set-sink-volume 0 -2%")
    ),

    Key(
        [], "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 3")
    ),
    Key(
        [], "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 3")
    ),
    Key([mod], "apostrophe", lazy.to_screen(0), desc="Move to first screen"),
    Key([mod], "backslash", lazy.to_screen(1), desc="Move to second screen"),

    Key([mod], "s", lazy.group["sys"].toscreen(), desc="Move to 'sys' group"),
    Key([mod], "d", lazy.group["dev"].toscreen(), desc="Move to 'dev' group"),
    Key([mod], "w", lazy.group["www"].toscreen(), desc="Move to 'www' group"),
    Key([mod], "p", lazy.group["psw"].toscreen(), desc="Move to 'psw' group"),
    Key([mod], "r", lazy.group["rdp"].toscreen(), desc="Move to 'rdp' group"),
    Key([mod], "period", lazy.group["..."].toscreen(), desc="Move to '...' group"),
    Key([mod], "m", lazy.group["mail"].toscreen(), desc="Move to 'mail' group"),
    Key([mod], "c", lazy.group["cal"].toscreen(), desc="Move to 'cal' group"),

    Key([mod, "shift"], "s", lazy.window.togroup("sys"), desc="Move window to 'sys' group"),
    Key([mod, "shift"], "d", lazy.window.togroup("dev"), desc="Move window to 'dev' group"),
    Key([mod, "shift"], "w", lazy.window.togroup("www"), desc="Move window to 'www' group"),
    Key([mod, "shift"], "p", lazy.window.togroup("psw"), desc="Move window to 'psw' group"),
    Key([mod, "shift"], "r", lazy.window.togroup("rdp"), desc="Move window to 'rdp' group"),
    Key([mod, "shift"], "period", lazy.window.togroup("..."), desc="Move window to '...' group"),
    Key([mod, "shift"], "m", lazy.window.togroup("mail"), desc="Move window to 'mail' group"),
    Key([mod, "shift"], "c", lazy.window.togroup("cal"), desc="Move window to 'cal' group"),
]

groups = [
    Group("sys", spawn="kitty"),
    Group("dev", spawn="kitty"),
    Group("www", spawn="firefox"),
    Group("psw", spawn="keepassxc", layout="floating"),
    Group("rdp"),
    Group("..."),
    Group("mail", spawn="mailspring"),
    Group("cal", spawn="gnome-calendar"),
]

layouts = [
    layout.MonadTall(
        border_focus='#bd93f9',
        border_normal='#222222',
        border_width=1,
        single_border_width=0,
        margin=0,
        single_margin=0,
        ratio=.618
    ),
    layout.Floating(
        border_focus='#bd93f9',
        border_normal='#222222',
        border_width=1,
    ),
]

widget_defaults = dict(
    font='IBM Plex Sans',
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    block_highlight_text_color="#000000",
                    disable_drag=True,
                    highlight_method='block',
                    other_screen_border='#ffce99',
                    other_current_screen_border='#ff9c33',
                    rounded=False,
                    this_screen_border='#d3b7fb',
                    this_current_screen_border='#a76ef7',
                    urgent_border='#00ff00',
                ),
                widget.TextBox(text=' ????'),
                widget.CurrentLayout(
                    foreground="#999999",
                ),
                widget.WindowCount(
                    text_format=': {num}',
                    foreground="#999999",
                ),
                widget.WindowName(
                    format=' ???? {state}{name}',
                    foreground="#777777",
                ),
                widget.Prompt(
                    background='#a76ef7',
                    foreground='#000000',
                    prompt=' ???? {prompt}: ',
                ),
                widget.Volume(emoji=True),
                widget.Backlight(
                    backlight_name='intel_backlight',
                    format='?????? {percent:2.0%}'),
                widget.Wlan(
                    disconnected_message=' ?????? N/A',
                    interface='wlp0s20f3',
                    format=' ???? {essid}',
                    mouse_callbacks={'Button1': lazy.spawn(["sh", "-c", "nm-connection-editor"])}
                ),
                widget.Battery(
                    charge_char='???',
                    discharge_char='????',
                    empty_char='???',
                    format=' {char} {percent:2.0%} {hour:d}:{min:02d}',
                    full_char='????',
                    show_short_text=False,
                    unknown_char='???',
                    update_interval=10,
                ),
                widget.Clock(format=' ??? %a %d/%m/%Y #%W %H:%M'),
                widget.CheckUpdates(
                    distro='Arch_checkupdates',
                    display_format=' ???? {updates} ',
                    update_interval=1800,
                ),
                widget.QuickExit(
                    countdown_format='{}',
                    default_text='????',
                    foreground='#ff0000'
                )
            ],
            26,
            background="#111111",
            border_width=[0, 0, 1, 0],
            border_color="#bd93f9",
            opacity=.9
        ),
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/autostart')
    subprocess.call([home])

auto_minimize = True
wmname = "LG3D"
