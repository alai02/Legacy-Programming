
*> cis-3190 a4 - sieve of erotasthenes in cobol
*> author: alex lai
*> student number: 0920158
*> email: alai02@uoguelph.ca
*> Date: Friday April 6 2018

identification division.
program-id. sieve.

environment division.
input-output section.
file-control.
select filePtr assign "cobol_sieve.txt"
    organization is line sequential
    access mode is sequential.

data division.
file section.
fd filePtr.
01 numRecord pic x(30).

*> Declare variables for the algorithm
working-storage section.
01  i                usage unsigned-int.
01  j                usage unsigned-int.
01  formattedNum     pic z(8).

01  maxPrime         usage unsigned-int.
*> 01  maxPrime         usage unsigned-int value 1000000.
*> 01  maxPrime         usage unsigned-int value 1000000.

*> Declare boolean type with size dependant on upper limit
01  boolType.
    05  boolValue pic x value "1" occurs 1 to 1000000 times depending on maxPrime.            

*> Declare the arrray type values
88  isPrime value "1" false "0".

*> Program to compute prime numbers until user inputted upper limit is reached
procedure division.
    
    display "Sieve of Erotasthenes in COBOL".

    *> Ask for and accept user input for upper limit of primes
    display "Enter an upper limit of primes: " with no advancing
    accept maxPrime

    *> Loop through array and stop once i is greater than the square root of the upper limit
    move 2 to i
    perform until ( maxPrime < (i * i) )
        *> Set all multiples of the prime values to false
        if isPrime (i)
            compute j = i * 2
            perform until (maxPrime < j) 
                set isPrime (j) to false
                compute j = j + i
            end-perform
        end-if
        compute i = i + 1
    end-perform

    *> Open a file for writing 
    open output filePtr.

    *> Loop through array and write primes to file
    *> first converting the number to a z type to aviod leading zeros 
    *> and second converting it to a record type for file IO
    move 2 to i
    perform until (maxPrime < i)
        if isPrime (i)
            move i to formattedNum
            write numRecord from formattedNum
        end-if
        compute i = i + 1
    end-perform

    *> Close the output file
    close filePtr.

stop run.
