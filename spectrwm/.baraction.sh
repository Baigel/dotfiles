#!/bin/bash
# baraction.sh for spectrwm status bar
# From http://wiki.archlinux.org/index.php/Scrotwm

SLEEP_SEC=5
#loops forever outputting a line every SLEEP_SEC secs
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
            POWER="${CHARGE}% ch"
            else                                                                                                                                         
                #is only on AC                                                                                                                       
                POWER="AC"                                                                                                                           
                fi
                else # hence is not on AC so is discharging battery
                    POWER="${CHARGE}% disch"
                    # if [ "$CHARGE -gt "20" ]
                    # then
                    # #TO DO make orange for > 20%
                    # POWER="${CHARGE}%"
                    # else
                    # #TO DO make red for < 20%# POWER="${CHARGE}%"
                    # fi
                    fi
                    POWER_STR="Bat:$POWER"
                    
                    #spectrwm bar_print can't handle UTF-8 characters, such as degree symbol
                    #Core 0:      +67.0?C  (crit = +100.0?C)
                    eval $(sensors 2>/dev/null | sed s/[?+]//g | awk '/^Core 0/ {printf "CORE0TEMP=%s;", $3}; /^Core 1/ {printf "CORE1TEMP=%s;",$3}; /^fan1/ {printf "FANSPD=%s;",$2};' -)
                    TEMP_STR="Tcpu=$CORE0TEMP,$CORE1TEMP"
                    
                    WLAN_ESSID=$(iwconfig wlp3s0 | awk -F "\"" '/wlp3s0/ { print $2 }')
                    #eval $(cat /proc/net/wireless | sed s/[.]//g | awk '/wlp3s0/ {printf "WLAN_QULTY=%s; WLAN_SIGNL=%s; WLAN_NOISE=%s", $3,$4,$5};' -)
                    #BCSCRIPT="scale=0;a=100*$WLAN_QULTY/70;print a"
                    #WLAN_QPCT=`echo $BCSCRIPT | bc -l`
                    #WLAN_POWER=`iwconfig 2>/dev/null| grep "Tx-Power"| awk {'print $4'}|sed s/Tx-Power=//`
                    WLAN_STR="$WLAN_ESSID"
                    
                    #CPUFREQ_STR=`echo "Freq:"$(cat /proc/cpuinfo | grep 'cpu MHz' | sed 's/.*: //g; s/\..*//g;')`
                    CPULOAD_STR="Load:$(uptime | sed 's/.*://; s/,//g')"
                    
                    eval $(awk '/^MemTotal/ {printf "MTOT=%s;", $2}; /^MemFree/ {printf "MFREE=%s;",$2}' /proc/meminfo)
                    MUSED=$(( $MTOT - $MFREE ))
                    MUSEDPT=$(( ($MUSED * 100) / $MTOT ))
                    MEM_STR="Mem:${MUSEDPT}%"
                    
                    echo -e "$POWER_STR  $TEMP_STR  $CPULOAD_STR  $MEM_STR  $WLAN_STR"
                    #alternatively if you prefer a different date format
                    #DATE_STR=`date +"%H:%M %a %d %b`
                    #echo -e "$DATE_STR   $POWER_STR  $TEMP_STR  $CPUFREQ_STR  $CPULOAD_STR  $MEM_STR  $WLAN_STR"
                    
                    sleep $SLEEP_SEC
                    done
