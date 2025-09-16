static const unsigned int borderpx  = 1;
static const unsigned int snap = 32;
static const int showbar = 1;
static const int topbar = 1;
static const char *fonts[] = { "IBM Plex Sans:size=11" };
static const char *colors[][3] = {
	[SchemeNorm] = { "#111111", "#eff1f5", "#111111" },
	[SchemeSel]  = { "#111111", "#ccd0da",  "#0066ff"  },
};
static const int refreshrate = 60;

static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7" };

static const Rule rules[] = {
	{ "Remmina", NULL, NULL, 0, 1, -1 },
};

static const float mfact = 0.55;
static const int nmaster = 1;  
static const int resizehints = 0;
static const int lockfullscreen = 1;

static const Layout layouts[] = {
	{ "[]=", tile },
	{ "><>", NULL },
	{ "[M]", monocle },
};

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY, KEY, view, {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask, KEY, toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask, KEY, tag, {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY, toggletag, {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *browsercmd[]  = { "firefox", NULL };

#include "shift-tools.c"
#include "movestack.c"
static const Key keys[] = {
	{ MODKEY, XK_semicolon, spawn, {.v = dmenucmd } },
	{ MODKEY, XK_Return, spawn, {.v = termcmd } },
	{ MODKEY, XK_g, zoom, {0} },
	{ MODKEY, XK_b, spawn, {.v = browsercmd } },
	{ MODKEY, XK_o, spawn, SHCMD("maim -s -u | xclip -selection clipboard -t image/png") },
	{ MODKEY, XK_f, spawn, SHCMD("flameshot gui") },
	{ MODKEY|ShiftMask, XK_o, spawn, SHCMD("maim -s -u ~/Pictures/Screenshots/$(date +%s).png") },
	{ MODKEY|ControlMask, XK_o, spawn, SHCMD("maim -s -u | tesseract stdin stdout | xclip -in -selection clipboard") },
	{ MODKEY, XK_n, spawn, SHCMD("dunstctl history-pop") },
	{ MODKEY|ShiftMask, XK_n, spawn, SHCMD("dunstctl close-all") },
	{ MODKEY|ControlMask, XK_x, spawn, SHCMD("nitrogen --force-setter=xinerama --head=0 --set-zoom-fill --random & nitrogen --force-setter=xinerama --head=1 --set-zoom-fill --random &") },
	{ MODKEY, XK_a, spawn, SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle & pkill -RTMIN+1 dwmblocks") },
	{ MODKEY|ShiftMask, XK_a, spawn, SHCMD("pactl -- set-sink-volume 0 +2% & pkill -RTMIN+1 dwmblocks") },
	{ MODKEY|ControlMask, XK_a, spawn, SHCMD("pactl -- set-sink-volume 0 -2% & pkill -RTMIN+1 dwmblocks") },
	{ MODKEY, XK_s, spawn, SHCMD("~/.config/brightness + eDP-1 0.02 & pkill -RTMIN+2 dwmblocks") },
	{ MODKEY|ShiftMask, XK_s, spawn, SHCMD("~/.config/brightness - eDP-1 0.02 & pkill -RTMIN+2 dwmblocks") },
	{ MODKEY, XK_j, focusstack, {.i = +1 } },
	{ MODKEY, XK_Down, focusstack, {.i = +1 } },
	{ MODKEY, XK_k, focusstack, {.i = -1 } },
	{ MODKEY, XK_u, movestack, {.i = +1 } },
	{ MODKEY, XK_i, movestack, {.i = -1 } },
	{ MODKEY, XK_Up, focusstack, {.i = -1 } },
	{ MODKEY|ShiftMask, XK_j, setmfact, {.f = -0.05} },
	{ MODKEY|ShiftMask, XK_k, setmfact, {.f = +0.05} },
	{ MODKEY, XK_l, shiftview, { .i = +1 } },
	{ MODKEY, XK_Right,  shiftview,    { .i = +1 } },
	{ MODKEY, XK_h, shiftview, { .i = -1 } },
	{ MODKEY, XK_Left, shiftview, { .i = -1 } },
	{ MODKEY|ShiftMask, XK_l, shifttag, { .i = +1 } },
	{ MODKEY|ShiftMask, XK_Right, shifttag, { .i = +1 } },
	{ MODKEY|ShiftMask, XK_h, shifttag, { .i = -1 } },
	{ MODKEY|ShiftMask, XK_Left, shifttag, { .i = -1 } },
	{ MODKEY|ShiftMask, XK_i, incnmaster, {.i = +1 } },
	{ MODKEY|ShiftMask, XK_d, incnmaster, {.i = -1 } },
	{ MODKEY, XK_backslash, focusmon, {.i = +1 } },
	{ MODKEY, XK_apostrophe, focusmon, {.i = -1 } },
	{ MODKEY, XK_BackSpace, togglefloating, { 0 } },
	TAGKEYS( XK_1, 0)
	TAGKEYS( XK_2, 1)
	TAGKEYS( XK_3, 2)
	TAGKEYS( XK_4, 3)
	TAGKEYS( XK_5, 4)
	TAGKEYS( XK_6, 5)
	TAGKEYS( XK_7, 6)
	{ MODKEY, XK_comma, tagmon, {.i = -1} },
	{ MODKEY, XK_period, tagmon, {.i = +1} },
	{ MODKEY|ShiftMask, XK_c, killclient, {0} },
	{ MODKEY|ShiftMask, XK_q, quit, {0} },};

static const Button buttons[] = {
	{ ClkLtSymbol, 0, Button1, setlayout, {0} },
	{ ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },
	{ ClkWinTitle, 0, Button2, zoom, {0} },
	{ ClkStatusText, 0, Button2, spawn, {.v = termcmd } },
	{ ClkClientWin, MODKEY, Button1, movemouse, {0} },
	{ ClkClientWin, MODKEY, Button2, togglefloating, {0} },
	{ ClkClientWin, MODKEY, Button3, resizemouse,    {0} },
	{ ClkTagBar, 0, Button1, view, {0} },
	{ ClkTagBar, 0, Button3, toggleview, {0} },
	{ ClkTagBar, MODKEY, Button1, tag, {0} },
	{ ClkTagBar, MODKEY, Button3, toggletag, {0} },
};

