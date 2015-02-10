ping "$DATABASE_HOST"
res="$?"

if [ "$res" -ne 0 ] 
then
	echo "Unable to connect to database at $DATABASE_HOST" > /dev/stderr
	exit "$res"
fi

if [ "$DATABASE_TYPE" = "MongoDB" ]
then
  mongo --host "$DATABASE_HOST" --c "db.testData.insert( { x : 1 } )"
  res1="$?"
  mongo --host "$DATABASE_HOST" --c "db.testData.find()"
  res2="$?"
  mongo --host "$DATABASE_HOST" --c "db.testData.remove()"
  res3="$?"
elif [ "$DATABASE_TYPE" = "PostgreSQL" ]
then	
	service postgresql status
	res="$?"
fi

if [ "$res1" -ne 0 ] 
then
	echo "Unable to insert data in $DATABASE_TYPE at $DATABASE_HOST"
	exit "$res1"
elif [ "$res2" -ne 0 ]
then
	echo "Unable to query data in $DATABASE_TYPE at $DATABASE_HOST"
	exit "$res2"
elif [ "$res3" -ne 0 ]
then
	echo "Unable to delete data in $DATABASE_TYPE at $DATABASE_HOST"
	exit "$res3"
fi 
