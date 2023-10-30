//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", " ~/.config/getvolume", 0, 1},
	{" 📡 ", "nmcli -t -f active,ssid dev wifi | grep -E '^yes' | cut -d: -f2", 30, 0},
	{" 🔋 ", "acpi | awk '{print $4}' | sed 's/,//g'", 30, 0},
	{" ⏰ ", "date '+%d/%m/%Y #%W %H:%M '", 5, 0},
	{" 🦣 ", "~/.config/pacupdate", 300, 0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 5;
