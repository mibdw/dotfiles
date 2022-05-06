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

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod], "q", lazy.restart(), desc="Restart Qtile, preserve windows"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "semicolon", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    Key([mod, "shift"], "s", 
        lazy.spawn(["sh", "-c", "maim -s -u | xclip -selection clipboard -t image/png"])
        , desc="Copy screenshot selection to clipboard"),

    Key(
        [mod, "shift"], "d",
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

    Key([mod], "comma", lazy.to_screen(0), desc="Move to first screen"),
    Key([mod], "period", lazy.to_screen(1), desc="Move to second screen"),

    Key([mod], "1", lazy.group["term"].toscreen(), desc="Move to 'term' group"),
    Key([mod], "2", lazy.group["dev"].toscreen(), desc="Move to 'dev' group"),
    Key([mod], "3", lazy.group["www"].toscreen(), desc="Move to 'www' group"),
    Key([mod], "4", lazy.group["sys"].toscreen(), desc="Move to 'sys' group"),
    Key([mod], "5", lazy.group["rdp"].toscreen(), desc="Move to 'rdp' group"),
    Key([mod], "6", lazy.group["..."].toscreen(), desc="Move to '...' group"),

    Key([mod, "shift"], "1", lazy.window.togroup("term"), desc="Move window to 'term' group"),
    Key([mod, "shift"], "2", lazy.window.togroup("dev"), desc="Move window to 'dev' group"),
    Key([mod, "shift"], "3", lazy.window.togroup("www"), desc="Move window to 'www' group"),
    Key([mod, "shift"], "4", lazy.window.togroup("sys"), desc="Move window to 'sys' group"),
    Key([mod, "shift"], "5", lazy.window.togroup("rdp"), desc="Move window to 'rdp' group"),
    Key([mod, "shift"], "6", lazy.window.togroup("..."), desc="Move window to '...' group"),
]

groups = [
    Group("term", spawn="kitty"),
    Group("dev", spawn="kitty"),
    Group("www", spawn="firefox"),
    Group("sys", spawn="keepassxc", layout="floating"),
    Group("rdp"),
    Group("..."),
]

layouts = [
    layout.MonadTall(
        border_focus='#00ff00',
        border_normal='#222222',
        border_width=3,
        single_border_width=3,
        margin=8,
        single_margin=8,
    ),
    layout.Max(),
    layout.Tile(
        border_focus='#00ff00',
        border_normal='#222222',
        border_width=3,
        margin=8,
    ),
    layout.Floating(
        border_focus='#00ff00',
        border_normal='#222222',
        border_width=3,
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
                widget.TextBox(text='🦆'),
                widget.GroupBox(
                    block_highlight_text_color="#ffffff",
                    disable_drag=True,
                    highlight_method='block',
                    other_screen_border='#ff99ff',
                    other_current_screen_border='#ff00ff',
                    rounded=False,
                    this_screen_border='#9999ff',
                    this_current_screen_border='#0000ff',
                    urgent_border='#00ff00',
                ),
                widget.TextBox(text='🍔'),
                widget.CurrentLayout(
                    foreground="#999999",
                ),
                widget.WindowCount(
                    text_format=': {num}',
                    foreground="#999999",
                ),
                widget.Prompt(
                    background='#ff00ff',
                    foreground='#ffffff',
                    prompt=' 🔫 {prompt}: ',
                ),
                widget.WindowName(
                    format=' 🍕 {state}{name}',
                    foreground="#777777",
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Volume(emoji=True),
                widget.Backlight(
                    backlight_name='intel_backlight',
                    format='☀️ {percent:2.0%}'),
                widget.Wlan(
                    disconnected_message=' ⛱️ N/A',
                    interface='wlp0s20f3',
                    format=' 📡 {essid}'
                ),
                widget.Battery(
                    charge_char='⚡',
                    discharge_char='🔥',
                    empty_char='⛺',
                    format=' {char} {percent:2.0%} {hour:d}:{min:02d}',
                    full_char='🔋',
                    show_short_text=False,
                    unknown_char='⚡',
                    update_interval=10,
                ),
                widget.Clock(format=' ⏰ %a %d/%m/%Y #%W %H:%M'),
                widget.CheckUpdates(
                    distro='Arch_checkupdates',
                    display_format=' 🦣 {updates} ',
                    update_interval=1800,
                ),
                widget.QuickExit(
                    countdown_format='{}',
                    default_text='💥',
                    foreground='#ff0000'
                )
            ],
            26,
            opacity=0.8
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
