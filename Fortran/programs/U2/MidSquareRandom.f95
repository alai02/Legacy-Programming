! program to generate pseudorandomnumbers
! Start with a four-digit number, called the seed
! Square it to obtain an eight-digit number (add a leading zero if necessary)
! Take the middle four digits as the next random number

program middlesquareRN
	implicit none

	integer, external :: midsqr
	integer :: i, n, seed

	write (*,*) "Enter a seed value"
	read(*,*) seed

	write (*,*) "Enter the amount of random numbers to generate"
	read (*,*) n

	do i = 1, n
		seed = midsqr(seed)
		write(*,*) "Random number: ", seed
	end do
	

end program middlesquareRN

integer function midsqr(seed)
	implicit none
	
	integer, intent(in) :: seed
	integer :: i, random
	integer*16 :: squaredSeed

	squaredSeed = (seed**2)
	random = 0

	! write (*,*) "Squared seed: ", squaredSeed
	! If n = 4, i = 5

	do i = 5, 2, -1
		random = random + ( (10**(i-2)) * ( squaredSeed/10**i-10*(squaredSeed/10**(i+1)) ) )
		! write (*,*) random
	end do

	midsqr = random

end function midsqr
