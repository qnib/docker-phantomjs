#!/bin/bash

TS_START=$(date +%s)
TIME_START=$(date +"%F_%H-%M-%S")
FILE_SUFFIX=$(date +"%F_%H%M%S")
if [ -z ${SCREENSHOT_FILE_PATH} ];then
    SCREENSHOT_FILE_PATH=/opt/qnib/phantomjs/reports
fi
TS_ITER=$(echo ${SCREENSHOT_TS} |tr -d '"')
if [ -z "${TS_ITER}" ];then
  TS_ITER=0
fi
CNT=0
SCREEN_URL=$(echo ${SCREENSHOT_URL} |tr -d '"')
for TS in ${TS_ITER};do
  while [ $(date +%s) -lt $(echo "${TS_START}+${TS}" |bc) ];do
    sleep 1
  done
  TIMESTAMP=$(date +"%F %H:%M:%S")
  phantomjs /opt/qnib/phantomjs/bin/take_screenshot.js ${SCREEN_URL} ${SCREENSHOT_FILE_PATH}/${TIME_START}_t${TS}_${SCREENSHOT_NAME}.png ${SCREENSHOT_TOKEN}
  ## Annotate TIMESTAMP
  convert -fill blue -gravity SouthEast -pointsize 30 ${SCREENSHOT_FILE_PATH}/${TIME_START}_t${TS}_${SCREENSHOT_NAME}.png -draw "text 5,5 'PIC TAKEN: ${TIMESTAMP}'" ${SCREENSHOT_FILE_PATH}/${TIME_START}_t${TS}_${SCREENSHOT_NAME}.png
  convert -fill blue -gravity SouthEast -pointsize 30 ${SCREENSHOT_FILE_PATH}/${TIME_START}_t${TS}_${SCREENSHOT_NAME}.png -draw "text 5,40 'DELAY: ${TS}sec'" ${SCREENSHOT_FILE_PATH}/${TIME_START}_t${TS}_${SCREENSHOT_NAME}.png
  CNT=$(echo "${CNT}+1" |bc)
done
