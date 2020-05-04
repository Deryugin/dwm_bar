#!/bin/sh

# A dwm_bar function to print the weather from wttr.in
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: curl

# Change the value of LOCATION to match your city

WEATHER_FILE=/tmp/dwm_weather

dwm_weather_update() {
    LOCATION=spb

    printf "%s" "$SEP1" > $WEATHER_FILE
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "%s" "$(curl -s wttr.in/$LOCATION?format=1)" >> $WEATHER_FILE
    else
        printf "WEA %s" "$(curl -s wttr.in/$LOCATION?format=1 | grep -o "[0-9].*")" >> $WEATHER_FILE
    fi
    printf "%s\n" "$SEP2" >> $WEATHER_FILE
}

dwm_weather() {
	# Force update if file doesn't exist
	[ ! -f "$WEATHER_FILE" ] && dwm_weather_update

	# Update if file is older than 5 minutes
	if test "`find $WEATHER_FILE -mmin +5`"; then
		dwm_weather_update
	fi
	
	cat $WEATHER_FILE
}

dwm_weather
