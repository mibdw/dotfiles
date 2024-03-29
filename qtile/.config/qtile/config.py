import os
import iwlib
import subprocess

from typing import List

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"
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

    Key([mod], "z", lazy.hide_show_bar("top"), desc="Hide/show bar"),

    Key([mod, "shift"], "u", 
        lazy.layout.grow(),
        desc="Grow master window"
    ),
    Key([mod, "shift"], "y", 
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

    Key([mod], "semicolon", lazy.spawn("rofi -show drun -display-drun \"🦆\""),
        desc="Spawn Rofi application launcher"),
    Key([mod], "e", lazy.spawn("rofi -show emoji -display-emoji \"🤣\""),
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
        [mod, "control"], "x",
        lazy.spawn(["sh", "-c", "nitrogen --force-setter=xinerama --head=0 --set-zoom-fill --random & nitrogen --force-setter=xinerama --head=1 --set-zoom-fill --random &"])
    ),
    Key([mod, "shift"], "h", 
        lazy.spawn(["sh", "-c", "putty -load Hermes -l benvandenende -pw Erasmus01a"])
        , desc="Launch Hermes"),

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

    Key([mod], "a", lazy.group["abc"].toscreen(), desc="Move to 'abc' group"),
    Key([mod], "d", lazy.group["dev"].toscreen(), desc="Move to 'dev' group"),
    Key([mod], "w", lazy.group["www"].toscreen(), desc="Move to 'www' group"),
    Key([mod], "x", lazy.group["xyz"].toscreen(), desc="Move to 'xyz' group"),
    Key([mod], "period", lazy.group["..."].toscreen(), desc="Move to '...' group"),

    Key([mod], "s", lazy.group["scratchpad"].dropdown_toggle("system"), desc="Toggle system scratchpad"),
    Key([mod], "y", lazy.group["scratchpad"].dropdown_toggle("term"), desc="Toggle terminal scratchpad"),
    Key([mod], "f", lazy.group["scratchpad"].dropdown_toggle("files"), desc="Toggle file manager scratchpad"),
    Key([mod], "p", lazy.group["scratchpad"].dropdown_toggle("keepassxc"), desc="Toggle password scratchpad"),
    Key([mod], "r", lazy.group["scratchpad"].dropdown_toggle("remote"), desc="Toggle RDP manager scratchpad"),
    Key([mod], "c", lazy.group["scratchpad"].dropdown_toggle("network"), desc="Toggle network manager scratchpad"),
    Key([mod], "t", lazy.group["scratchpad"].dropdown_toggle("thunderbird"), desc="Toggle e-mail client"),
    # Key([mod, "shift"], "h", lazy.group["scratchpad"].dropdown_toggle("hermes"), desc="Toggle Hermes scratchpad"),
    
    Key([mod, "shift"], "a", lazy.window.togroup("abc"), desc="Move window to 'abc' group"),
    Key([mod, "shift"], "d", lazy.window.togroup("dev"), desc="Move window to 'dev' group"),
    Key([mod, "shift"], "w", lazy.window.togroup("www"), desc="Move window to 'www' group"),
    Key([mod, "shift"], "x", lazy.window.togroup("xyz"), desc="Move window to 'xyz' group"),
    Key([mod, "shift"], "period", lazy.window.togroup("..."), desc="Move window to '...' group"),
]

layouts = [
    layout.MonadTall(
        border_focus='#bd93f9',
        border_normal='#222222',
        border_width=1,
        single_border_width=0,
        margin=0,
        single_margin=0,
        change_size=5,
        change_ratio=0.01,
        ratio=.5,
    ),
    layout.MonadWide(
        border_focus='#bd93f9',
        border_normal='#222222',
        border_width=1,
        single_border_width=0,
        margin=0,
        single_margin=0,
        change_size=5,
        change_ratio=0.01,
        ratio=.5,
    ),
]

groups = [
    Group("www", spawn="firefox"),
    Group("dev", spawn=terminal),
    Group("abc"),
    Group("xyz"),
    Group("..."),
    ScratchPad("scratchpad", [
        DropDown("system", 
            [terminal, "-e", "tmux", "new-session", "-A", "-s", "system"], 
            x=0.1, y=0.07, width=0.8, height=0.82, opacity=1, on_focus_lost_hide=False
        ),
        DropDown("term", 
            [terminal, "-e", "tmux", "new-session", "-A", "-s", "scratch"], 
            x=0.1, y=0.07, width=0.8, height=0.82, opacity=1, on_focus_lost_hide=False
        ),
        DropDown("files", 
            [terminal, "-e", "ranger"], 
            x=0.1, y=0.07, width=0.8, height=0.82, opacity=1, on_focus_lost_hide=False
        ),
        DropDown("keepassxc", "keepassxc", opacity=1, width=0.6, height=0.7, x=0.2, y=0.1, on_focus_lost_hide=False),
        DropDown("remote", "remmina", opacity=1, width=0.6, height=0.7, x=0.2, y=0.1, on_focus_lost_hide=False),
        DropDown("network", "nm-connection-editor", opacity=1, width=0.4, height=0.7, x=0.3, y=0.1, on_focus_lost_hide=False),
        DropDown("thunderbird", "/opt/thunderbird-beta/thunderbird", opacity=1, width=0.8, height=0.82, x=0.1, y=0.07, on_focus_lost_hide=False),
        # DropDown("hermes", "putty -load Hermes -l ben -pw Erasmus01a", opacity=1, width=0.6, height=0.7, x=0.2, y=0.15, on_focus_lost_hide=False),
    ]),
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
                    active="#111111",
                    inactive="#aaaaaa",
                    block_highlight_text_color="#ffffff",
                    disable_drag=True,
                    highlight_method='block',
                    other_screen_border='#acb0be',
                    other_current_screen_border='#fe640b',
                    rounded=False,
                    this_screen_border='#acb0be',
                    this_current_screen_border='#1e66f5',
                    urgent_border='#00ff00',
                ),
                widget.CurrentLayout(
                    fmt=' 🍔 {}',
                    foreground="#777777",
                ),
                widget.WindowName(
                    format=' 🍕 {state}{name}',
                    foreground="#777777",
                ),
                widget.Pomodoro(
                   prefix_inactive='🍅',
                   prefix_active='🍅',
                   foreground='#111111',
                ),
                widget.Volume(emoji=True),
                widget.Backlight(
                    backlight_name='intel_backlight',
                    format='☀️ {percent:2.0%}',
                    foreground='#111111',
                ),
                widget.Wlan(
                    disconnected_message=' ⛱️ N/A',
                    interface='wlp0s20f3',
                    format=' 📡 {essid}',
                    mouse_callbacks={'Button1': lazy.group["scratchpad"].dropdown_toggle("network")},
                    foreground='#111111',
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
                    foreground='#111111',
                ),
                widget.Clock(
                    format=' ⏰ %a %d/%m/%Y #%W %H:%M',
                    foreground='#111111',
                ),
                widget.CheckUpdates(
                    distro='Arch_checkupdates',
                    display_format=' 🦣 {updates} ',
                    update_interval=1800,
                    colour_have_updates='#111111',
                    colour_no_updates='#111111',
                    foreground='#111111',
                ),
                widget.QuickExit(
                    countdown_format='{}',
                    default_text='💥',
                    foreground='#111111',
                )
            ],
            26,
            background="#dce0e8",
            border_width=[0, 0, 1, 0],
            border_color="#bd93f9",
            opacity=1
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
floating_layout = layout.Floating(
    border_focus='#a76ef7',
    border_normal='#222222',
    border_width=1,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(title='nm-connection-editor'),  # GPG key password entry
        Match(title='putty'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/autostart')
    subprocess.call([home])

auto_minimize = True
wmname = "LG3D"
