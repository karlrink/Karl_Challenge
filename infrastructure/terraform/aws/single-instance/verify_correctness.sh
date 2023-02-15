#!/bin/bash


PUBLIC_IP=`grep '"public_ip":' terraform.tfstate | awk -F: '{print $2}' | sed 's/,//g' | sed 's/"//g'`
echo "Verify: $PUBLIC_IP"

if curl -s http://$PUBLIC_IP/ | grep 301 1>/dev/null
then
  echo "OK: 301 Redirect working"
else
  echo "Fail: 301 test"
fi

if curl -s -k https://$PUBLIC_IP/ | grep 301 1>/dev/null
then
  echo "OK: Hello working"
else
  echo "Fail: Hello test"
fi

if openssl s_client -showcerts -connect $PUBLIC_IP:443 </dev/null | grep mydomain.com
then
  echo "OK: ssl cert is mydomain.com"
else
  echo "Fail: openssl test"
fi

