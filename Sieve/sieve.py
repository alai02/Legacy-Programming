
# CIS-3190 A4 - Sieve of Erotasthenes
# Author: Alex Lai
# Student Number: 0920158
# Email: alai02@uoguelph.ca
# Date: Friday April 6 2018

# Program to calcuate prime numbers until upper limit is reached
import math
import time

print 'Sieve of Erotasthenes in Python'

# Ask for and accept user input for upper limit
print 'Enter an upper limit of primes: '
maxPrime = raw_input()

# Set the input to a integer type
maxPrime = int(maxPrime)

# Initialzise array of boolean values with size of upper limit
isPrime = [False] * 2 + [True] * (maxPrime - 1) 

# Call time function for start time of the algorithm
startTime = time.time()

# Loop until square root of upper limit is reached
i = 2
while (i * i <= maxPrime):
    # Set multiples of prime values to false
    if isPrime[i]:
        for j in range(i * i, maxPrime + 1, i):
            isPrime[j] = False
    i = i + 1

# Call time function to get end time and compute execution time
endTime = time.time()
execTime = endTime - startTime

# Open file for output
file = open("py_sieve.txt","w+")

# Loop through array, writing prime values to file by converting them to strings
for i in xrange(maxPrime + 1):
    if isPrime[i]:
        file.write(str(i) + '\n')

# Close file and print out the execution time
file.close()
print 'Execution time: ', execTime, ' seconds'
