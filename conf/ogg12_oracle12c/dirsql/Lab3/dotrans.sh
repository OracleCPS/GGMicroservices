sqlplus amer/amer @database.sql
sleep 10
sqlplus amer/amer @seed_database.sql
sleep 30
sqlplus amer/amer @gentrans.sql
echo "Script Completed"

