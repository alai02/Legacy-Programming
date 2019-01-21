
! CIS-3190 A4 - Sieve of Erotasthenes in Fortran
! Author: Alex Lai
! Student Number: 0920158
! Email: alai02@uoguelph.ca
! Date: Friday April 6 2018

! Program to calculate primes until a user inputted upper limit is reached
program sieve
    implicit none
    
    ! Declare variables for algorithm and file IO
    integer :: i, j, maxPrime
    real :: startTime, endTime, execTime
    logical, dimension(:), allocatable :: isPrime

    write (*,'(a)') "Sieve of Erotasthenes in Fortran"
    
    ! Ask for and accept user input
    write (*,'(a)') "Enter an upper limit of primes: "
    read (*,*) maxPrime
    
    ! Allocate prime array to size of the limit
    allocate(isPrime(maxPrime))

    ! Initialze each boolean value in the array to true
    i = 1
    do while (i < maxPrime)
        isPrime(i) = .true.
        i = i +1
    end do
    
    ! Call cpu time for start of the algorithm
    call cpu_time(startTime)

    ! Loop through array until i is greater than the square root of the upper limit 
    i = 2
    do while (i * i <= maxPrime)
        if (isPrime(i) .eqv. .true.) then
            ! Set all multipules of the prime numbers to false
            j = i * 2
            do while (j <= maxPrime)
                isPrime(j) = .false.
                j = j + i
            end do  
        end if
        i = i + 1
    end do

    ! Call cpu time to get end time of algorithm and compute the runtime
    call cpu_time(endTime)
    execTime = (endTime - startTime)

    ! Open a file to write to, replaces a file if already exists
    open(1, file='fortran_sieve.txt', status='replace')  

    ! Write prime values to file using array 
    do i = 2, maxPrime
        if (isPrime(i) .eqv. .true.) then
            write(1,*) i
        end if
    end do

    ! Close file and print out the execution time
    close(1)
    write(*,*) 'Execution time: ', execTime, ' seconds'

end program sieve
    