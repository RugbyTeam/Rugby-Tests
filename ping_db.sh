ping "$DATABASE_HOST"
res="$?"

if [ "$res" -ne 0 ] 
then
	echo "Unable to connect to database at $DATABASE_HOST" > /dev/stderr
	exit "$res"
fi

if [ "$DATABASE_TYPE" = "MongoDB" ]
	mongo --host "$DATABASE_HOST" --eval "db.stats()"
	res="$?"
elif [ "$DATABASE_TYPE" = "PostgreSQL" ]
then	
	service postgresql status
	res="$?"
fi

if [ "$res" -ne 0 ] 
then
	echo "Unable to query $DATABASE_TYPE at $DATABASE_HOST"
	exit "$res"
fi 
