#!/bin/bash
day=`date "+%Y%m%d"`
now=`date "+%Y%m%d_%H%M%S"`

curl_header="-H 'authority: rowermevo.pl' \
-H 'pragma: no-cache' \
-H 'cache-control: no-cache' \
-H 'upgrade-insecure-requests: 1' \
-H 'user-agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36' \
-H 'dnt: 1' \
-H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' \
-H 'accept-encoding: gzip, deflate' \
-H 'accept-language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7' \
--compressed"

refresh_key(){
  eval curl https://rowermevo.pl/mapa-stacji/ $curl_header -s | grep 'ocations.js?key=\w*' -o > /home/ubuntu/mevo/tmp_key
  cat /home/ubuntu/mevo/tmp_key
}

mkdir -p /home/ubuntu/mevo/js/$day

echo `date +"[%Y-%m-%d %H:%M:%S]"` start
code=$(eval curl https://rowermevo.pl/l$(cat /home/ubuntu/mevo/tmp_key) $curl_header -w "%{http_code}" -s -o /home/ubuntu/mevo/js/$day/$now)

if [ $code != "200" ]
then
  echo "HTTP $code"
  sleep 30
  refresh_key
  code=$(eval curl https://rowermevo.pl/l$(cat /home/ubuntu/mevo/tmp_key) $curl_header -w "%{http_code}" -s -o /home/ubuntu/mevo/js/$day/$now)
  if [ $code != "200" ]
  then
    echo "Error after refresh_key HTTP $code"
  fi
fi

echo `date +"[%Y-%m-%d %H:%M:%S]"` stop

# CSV
#mkdir -p /home/ubuntu/mevo/csv/$day
#wget https://rowermevo.pl/maps/locations.txt?key=jF5puHQe3CqssPZh -O /home/ubuntu/mevo/csv/$day/$now.csv

