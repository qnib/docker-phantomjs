#!/bin/bash

TS_START=$(date +%s)
FILE_SUFFIX=$(date +"%F_%H%M%S")

TS_ITER=$(echo ${SCREENSHOT_TS} |tr -d '"')
if [ -z "${TS_ITER}" ];then
  TS_ITER=0
fi
CNT=0
for TS in ${TS_ITER};do
  while [ $(date +%s) -lt $(echo "${TS_START}+${TS}" |bc) ];do
    sleep 1
  done
  TIMESTAMP=$(date +"%F %H:%M:%S")
  phantomjs /opt/qnib/phantomjs/bin/take_screenshot.js ${SCREENSHOT_URL} /opt/qnib/phantomjs/reports/${SCREENSHOT_NAME}_${FILE_SUFFIX}_${CNT}_t${TS}.png
  ## Annotate TIMESTAMP
  convert -fill blue -gravity SouthEast -pointsize 30 /reports/consul_screen_${FILE_SUFFIX}_${CNT}_t${TS}.png -draw "text 5,5 'PIC TAKEN: ${TIMESTAMP}'" /reports/consul_screen_${FILE_SUFFIX}_${CNT}_t${TS}.png
  convert -fill blue -gravity SouthEast -pointsize 30 /reports/consul_screen_${FILE_SUFFIX}_${CNT}_t${TS}.png -draw "text 5,40 'DELAY: ${TS}sec'" /reports/consul_screen_${FILE_SUFFIX}_${CNT}_t${TS}.png
  CNT=$(echo "${CNT}+1" |bc)
done
