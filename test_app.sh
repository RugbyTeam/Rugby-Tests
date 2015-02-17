ping "$APPLICATION_HOST" -c 2 > /dev/null 
ping_res="$?"

if [ "$ping_res" -ne 0 ] 
then
	echo "Unable to connect to application at $APPLICATION_HOST" > /dev/stderr
	exit "$ping_res"
fi 

http_req_okay=$(curl -sIL "$APPLICATION_HOST" | grep '^HTTP/1.1 2[0-9]\{2\}')
if [ -z "$http_req_okay" ]
then
    echo "Application at $APPLICATION_HOST  did not respond with 2xx status request." > /dev/stderr
    exit 1
fi
