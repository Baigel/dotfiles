#!/bin/bash
# baraction.sh for spectrwm status bar
# From http://wiki.archlinux.org/index.php/Scrotwm

SLEEP_SEC=1

while :; do
    # power output
    BAT=`acpi -b`
    CHARGE=`acpi -b | awk '{printf("%d", $4)}'`
    AC=`acpi -a | awk '{printf("%s", $3)}'`
    # if AC connected
    if [ "$AC" = 'on-line' ]
        then
        #if battery connected and charging
        # TO DO check
        if [ -n "$BAT" ]
            then
            # TO DO make % green to show charged/ing
            POWER="+${CHARGE}%"
        else
            #is only on AC
            POWER="AC"
        fi
    else # hence is not on AC so is discharging battery
        POWER="-${CHARGE}%"
        # if [ "$CHARGE -gt "20" ]
        # then
        # #TO DO make orange for > 20%
        # POWER="${CHARGE}%"
        # else
        # #TO DO make red for < 20%# POWER="${CHARGE}%"
        # fi
    fi
    POWER_STR="Bat: $POWER"

    #spectrwm bar_print can't handle UTF-8 characters, such as degree symbol
    eval $(sensors 2>/dev/null | sed s/[?+]//g | awk '/^Core 0/ {printf "CORE0TEMP=%s;", $3}; /^Core 1/ {printf "CORE1TEMP=%s;",$3}; /^Core 2/ {printf "CORE2TEMP=%s;",$3}; /^Core 3/ {printf "CORE3TEMP=%s;",$3}; /^fan1/ {printf "FANSPD=%s;",$2};' -)
    TEMP_STR="CPU Temp: $CORE0TEMP, $CORE1TEMP, $CORE2TEMP, $CORE3TEMP"

    NETWORK=`nmcli | grep ' connected' | cut -d " " -f 4`
    [ -z "$NETWORK" ] && NETWORK="Disconnected"
    NET_STR="Net: $NETWORK"

    CPUFREQ_STR=`echo "CPU (GHz): "$(cat /proc/cpuinfo | grep 'cpu MHz' | sed 's/.*: //g; s/\..*//g;' | awk '{ total += $1; count++ } END { print total/count }' | awk '{print int($1)/1000}')`

    CPULOAD_STR="Load: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')"

    eval $(awk '/^MemTotal/ {printf "MTOT=%s;", $2}; /^MemFree/ {printf "MFREE=%s;",$2}' /proc/meminfo)
    MUSED=$(( $MTOT - $MFREE ))
    MUSEDPT=$(( ($MUSED * 100) / $MTOT ))
    MEM_STR="Mem: ${MUSEDPT}%"

    DATE_STR=$(date | cut -d " " -f 1-5)

	VOLUME="Vol: $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))"

    echo -e "$NET_STR    |    $POWER_STR    |    $TEMP_STR    |    $CPUFREQ_STR    |    $CPULOAD_STR    |    $MEM_STR    |    $VOLUME    |    $DATE_STR"

    sleep $SLEEP_SEC
done
