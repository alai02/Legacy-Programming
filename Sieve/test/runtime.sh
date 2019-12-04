#!/bin/bash

startTime=$(date +%s.%N)

./sieve

endTime=$(date +%s.%N)    

execTime=$(python -c "print(${endTime} - ${startTime})")

echo "Execution time: $execTime seconds"
