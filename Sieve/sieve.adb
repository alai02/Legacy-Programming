
-- CIS-3190 A4 - Sieve of Erotasthenes in Ada
-- Author: Alex Lai
-- Student Number: 0920158
-- Email: alai02@uoguelph.ca
-- Date: Friday April 6 2018

-- Import required libraries
with Ada.Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;

-- Program to compute prime numbers until a user inputted limit is reached
procedure sieve is

    -- Declare variables for iterations, file IO and runtime
    i : integer := 2;
    j : integer;
    maxPrime : integer;
    filePtr : Ada.Text_IO.File_Type;
    
    startTime, endTime : Time;
    execTime : Duration;
 
begin

    put_line("Sieve of Erotasthenes in Ada");

    -- Ask for and accept user input for upper limit
    put_line("Enter an upper limit of primes: ");
    get(maxPrime);

    -- Declare a boolean array type with the size of the user input and initialze the array
    declare
        isPrime: array(1 .. maxPrime) of Boolean := (1 => False, others => True);
    begin

        -- Call system clock for start of execution
        startTime := Clock;

        -- Loop through array and stop once it reaches the square root of the upper limit
        -- Check if number is prime and loop through all multiples of that number, setting them to false
        loop
            exit when (i * i) > maxPrime;
            if (isPrime(i)) then
                j := i + i;
                loop
                    exit when j > maxPrime;
                    isPrime(j) := False;
                    j := j + i;
                end loop;
            end if;
            i := i + 1;
        end loop;

        -- Call system clock for end of execution time and calculate the run time
        endTime := Clock;
        execTime := (endTime - startTime);
        
        -- Open a file for writing
        Create(filePtr, Ada.Text_IO.Out_File, "ada_sieve.txt");

        -- Loop through array, writing primes to the file, first converting the integer to a string
        for i in isPrime'Range loop
            if (isPrime(i)) then
                Unbounded_IO.Put(filePtr, To_Unbounded_String( Integer'Image( i ) ) );
            end if;
        end loop;
        
        -- Close file and output the execution time of the algorithm
        Close(filePtr);
        put_line("Execution time: " & Duration'Image(execTime) & " seconds");
    end;

end sieve;

