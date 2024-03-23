#!/bin/bash

# Create a new SQLite database
DB_FILE="test.db"
sqlite3 $DB_FILE "DROP TABLE IF EXISTS test;"
sqlite3 $DB_FILE "CREATE TABLE test (id INTEGER PRIMARY KEY, value TEXT);"

# Start the timer
start=$(date +%s%N)

# Insert some data
for i in {1..1000}
do
    sqlite3 $DB_FILE "INSERT INTO test (value) VALUES ('test$i');"
done

# Query the data
sqlite3 $DB_FILE "SELECT * FROM test;"

# End the timer
end=$(date +%s%N)
runtime=$((end-start))

# Print the runtime
echo "Runtime was $runtime nanoseconds"