#!/bin/sh

# Credentials
username="username"
password="password"

# URL and headers
url='http://172.16.1.1:8090/login.xml'
headers=(
  -H 'Accept: */*'
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8'
  -H 'Connection: keep-alive'
  -H 'Content-Type: application/x-www-form-urlencoded'
  -H 'DNT: 1'
  -H 'Origin: http://172.16.1.1:8090'
  -H 'Referer: http://172.16.1.1:8090/'
  -H 'Sec-GPC: 1'
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.67 Safari/537.36'
)

# Data to be sent
data="mode=191&username=$username&password=$password&a=1653625623569&producttype=0"

# Curl options
options=(
  --data-raw "$data"
  --connect-timeout 5
  --compressed
  --insecure
)

# Perform the request
response=$(curl -s "$url" "${headers[@]}" "${options[@]}")

# Parse and display response
status=$(echo "$response" | sed -n 's:.*<status><!\[CDATA\[\(.*\)\]\]></status>.*:\1:p')
message=$(echo "$response" | sed -n 's:.*<message><!\[CDATA\[\(.*\)\]\]></message>.*:\1:p')

if [ "$status" = "LIVE" ]; then
  echo "Login Successful"
  echo "Message: $message"
else
  echo "Login Failed"
  echo "Error: $message"
fi
