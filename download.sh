#!/bin/bash
day=`date "+%Y%m%d"`
now=`date "+%Y%m%d_%H%M%S"`

curlx(){
result=$(curl $1 \
-H 'authority: rowermevo.pl' \
-H 'pragma: no-cache' \
-H 'cache-control: no-cache' \
-H 'upgrade-insecure-requests: 1' \
-H 'user-agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' \
-H 'dnt: 1' \
-H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
-H 'accept-encoding: gzip, deflate' \
-H 'accept-language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
--compressed -s)
}

mkdir -p /home/ubuntu/mevo/js/$day

echo `date +"[%Y-%m-%d %H:%M:%S]"` start
curlx https://rowermevo.pl/mapa-stacji/
link=$(echo $result |grep 'locations.js?key=\w*' -o)
echo $link

curlx https://rowermevo.pl/$link
echo $result > /home/ubuntu/mevo/js/$day/$now
echo  `date +"[%Y-%m-%d %H:%M:%S]"` js


#mkdir -p /home/ubuntu/mevo/csv/$day
#wget https://rowermevo.pl/maps/locations.txt?key=jF5puHQe3CqssPZh -O /home/ubuntu/mevo/csv/$day/$now.csv
#echo `date +"[%Y-%m-%d %H:%M:%S]"` csv
#wget https://rowermevo.pl/locations.js?key=4f54c0c4aef018bd8ecea650d8b364e3744448ca -O /home/ubuntu/mevo/js/$day/$now
#echo  `date +"[%Y-%m-%d %H:%M:%S]"` js
