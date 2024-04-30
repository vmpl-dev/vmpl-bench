#!/bin/bash

echo "Running sqlite3..."
BENCH_HOME=/home/benshan/vmpl-bench
source $BENCH_HOME/scripts/common.sh
pushd sqlite3

# Create a new SQLite database
DB_FILE="test.db"

if [ $strace_enabled -eq 1 ]; then
    echo "Running redis with strace..."
    strace -o sqlite3.strace sqlite3 $DB_FILE
else
    sqlite3 $DB_FILE "DROP TABLE IF EXISTS test;"
    test -z $? || exit $?
    sqlite3 $DB_FILE "CREATE TABLE test (id INTEGER PRIMARY KEY, value TEXT);"
    test -z $? || exit $?
    # Start the timer
    start=$(date +%s%N)

    # Insert some data
    for i in {1..1000}
    do
        sqlite3 $DB_FILE "INSERT INTO test (value) VALUES ('test$i');"
        test -z $? || exit $?
    done

    # Query the data
    sqlite3 $DB_FILE "SELECT * FROM test;"
    test -z $? || exit $?

    # End the timer
    end=$(date +%s%N)
    runtime=$((end-start))

    # Print the runtime
    echo "Runtime was $runtime nanoseconds"
fi
popd