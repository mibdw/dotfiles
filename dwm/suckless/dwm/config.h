/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "IBM Plex Sans:size=11" };
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { "#111111", "#eff1f5", "#eff1f5" },
	[SchemeSel]  = { "#111111", "#dce0e8",  "#1e66f5"  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor    float x,y,w,h         floatborderpx*/
	{ "Remmina",  NULL,       NULL,       0,            1,           -1,        460,140,1000,800,     1 },
	{ "KeePassXC",  NULL,     NULL,       0,            1,           -1,        360,140,1200,800,     1 },
	{ "Putty",    NULL,       NULL,       1 << 8,       0,           -1,        460,140,1000,800,     1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "🚚",      tile },    /* first entry is default */
	{ "🎈",      NULL },    /* no layout function means floating behavior */
	{ "👀",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browsercmd[]  = { "firefox", NULL };

#include "shift-tools.c"
static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_semicolon,      spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_b,      spawn,          {.v = browsercmd } },
  { MODKEY,                       XK_o,      spawn,          SHCMD("maim -s -u | xclip -selection clipboard -t image/png") },
  { MODKEY|ShiftMask,             XK_o,      spawn,          SHCMD("maim -s -u ~/Pictures/Screenshots/$(date +%s).png") },
  { MODKEY,                       XK_n,      spawn,          SHCMD("dunstctl history-pop") },
  { MODKEY|ShiftMask,             XK_n,      spawn,          SHCMD("dunstctl close-all") },
  { MODKEY|ControlMask,           XK_x,      spawn,          SHCMD("nitrogen --force-setter=xinerama --head=0 --set-zoom-fill --random & nitrogen --force-setter=xinerama --head=1 --set-zoom-fill --random &") },
  { MODKEY|ControlMask,           XK_h,      spawn,          SHCMD("putty -load Hermes -l benvandenende -pw Erasmus01a") },
  { MODKEY,                       XK_a,      spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle & pkill -RTMIN+1 dwmblocks") },
  { MODKEY|ShiftMask,             XK_a,      spawn,          SHCMD("pactl -- set-sink-volume 0 +2% & pkill -RTMIN+1 dwmblocks") },
  { MODKEY|ControlMask,           XK_a,      spawn,          SHCMD("pactl -- set-sink-volume 0 -2% & pkill -RTMIN+1 dwmblocks") },
  { MODKEY,                       XK_s,      spawn,          SHCMD("~/.config/brightness + eDP-1 0.02 & pkill -RTMIN+2 dwmblocks") },
  { MODKEY|ShiftMask,             XK_s,      spawn,          SHCMD("~/.config/brightness - eDP-1 0.02 & pkill -RTMIN+2 dwmblocks") },

	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Down,   focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Up,     focusstack,     {.i = -1 } },

	{ MODKEY|ShiftMask,             XK_j,      setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_Down,   setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_k,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Up,     setmfact,       {.f = +0.05} },

	{ MODKEY,                       XK_l,      shiftview,    { .i = +1 } },
	{ MODKEY,                       XK_Right,  shiftview,    { .i = +1 } },
  { MODKEY,	                      XK_h,      shiftview,    { .i = -1 } },
  { MODKEY,	                      XK_Left,   shiftview,    { .i = -1 } },

	{ MODKEY|ShiftMask,             XK_l,	     shifttag,           { .i = +1 } },
	{ MODKEY|ShiftMask,             XK_Right,	 shifttag,           { .i = +1 } },
	{ MODKEY|ShiftMask,             XK_h,	     shifttag,           { .i = -1 } },
	{ MODKEY|ShiftMask,             XK_Left,	 shifttag,           { .i = -1 } },

	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },

	{ MODKEY,                       XK_backslash,      focusmon,     {.i = +1 } },
	{ MODKEY,                       XK_apostrophe,     focusmon,     {.i = -1 } },
	{ MODKEY,                       XK_BackSpace,      togglefloating,     { 0 } },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

