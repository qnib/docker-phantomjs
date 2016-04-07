FROM qnib/d-consul


RUN apt-get update \
 && apt-get -y install build-essential g++ flex bison gperf ruby perl libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev libpng-dev libjpeg-dev python libx11-dev libxext-dev git-core \
 && cd /tmp \
 && git clone git://github.com/ariya/phantomjs.git \
 && cd phantomjs \
 && git checkout 2.1.1 \
 && git submodule init \
 && git submodule update \
 && cd /tmp/phantomjs \
 && python build.py --confirm \
 && cd /root/ \
 && cp /tmp/phantomjs/bin/phantomjs /usr/local/bin/
# && rm -rf /tmp/*
