#!/bin/bash

# Note that data was imported from the StayFree app, running on mobile

# Dependencies
# perl-xls2csv
# 

xls2csv -x *.xls -n 1 -c usage_time.csv -b WINDOWS-1252
xls2csv -x *.xls -n 2 -c app_launches.csv -b WINDOWS-1252
xls2csv -x *.xls -n 3 -c notifications.csv -b WINDOWS-1252

cat usage_time.csv | tail -3 | head -1 | sed 's/"//g' | cut -d"," -f2

gnuplot <<- EOF
	reset
	plot '

EOF

