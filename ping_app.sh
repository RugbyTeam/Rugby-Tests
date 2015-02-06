ping "$APPLICATION_HOST"
res="$?"

if ["$res" -ne 0] 
then
	echo "Unable to connect to application at $APPLICATION_HOST" > /dev/stderr
	exit "$res"
fi 
