ping "$DATABASE_HOST" -c 2
res_ping="$?"

if [ "$res_ping" -ne 0 ] 
then
	echo "Unable to connect to MongoDB at $DATABASE_HOST" > /dev/stderr
	exit "$res_ping"
fi

mongo --host "$DATABASE_HOST" --eval "db.testData.insert( { x : 1 } )"
res_insert="$?"
mongo --host "$DATABASE_HOST" --eval "db.testData.find()"
res_find="$?"
mongo --host "$DATABASE_HOST" --eval "db.testData.remove({x: 1})"
res_remove="$?"

if [ "$res_insert" -ne 0 ] 
then
	echo "Unable to insert data MongoDB testData collection at $DATABASE_HOST"
	exit "$res_insert"
elif [ "$res_find" -ne 0 ]
then
	echo "Unable to query data in MongoDB testData collection at $DATABASE_HOST"
	exit "$res_find"
elif [ "$res_remove" -ne 0 ]
then
	echo "Unable to delete data in MongoDB testData collection at $DATABASE_HOST"
	exit "$res_remove"
fi 
