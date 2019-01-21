/**
 * CIS-3190 A4 - Sieve of Erotasthenes in C
 * Author: Alex Lai
 * Student Number: 0920158
 * Email: alai02@uoguelph.ca
 * Date: Friday April 6 2018
**/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>

// Program to calcuate prime numbers until upper limit is reached
int main(void) {

    int maxPrime;

    printf("Sieve of Erotasthenes in C\n");

    // Ask for and accept user input
    printf("Enter an upper limit of primes: ");
    scanf("%d", &maxPrime);

    // Declare array of booleans with size entered from user
    bool isPrime[maxPrime + 1];
    memset(isPrime, true, sizeof(isPrime));
    
    // Call clock to get start time of algorithm 
    clock_t startTime = clock();
    
    // Start at 2 since 1 is not prime and loop until square root of upper limit is reached
    for (int i = 2; i * i <= maxPrime; i++) {
        // If array at i is prime, set all multiples to false
        if (isPrime[i]) {
            for (int j = i * 2; j <= maxPrime; j += i) {
                isPrime[j] = false;
            }
        }
    }
    
    // Call clock to get end time of the algorithm and calculate runtime
    clock_t endTime = clock();
    double execTime = (double)(endTime - startTime) / CLOCKS_PER_SEC;

    // Open file for writing and check for failure
    FILE* filePtr = fopen("c_sieve.txt", "w+");
    if (!filePtr) return EXIT_FAILURE;

    // Loop through array, writing prime valus to a file
    for (int i = 2; i <= maxPrime; i++) {
        if (isPrime[i]) {
            fprintf(filePtr, "%d\n", i);
        }
    }

    // Close the file and print out execution time to stdout
    fclose(filePtr);
    printf("Execution time: %lf seconds\n", execTime);

    return EXIT_SUCCESS;
}