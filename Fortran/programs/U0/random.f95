! program randomEG
!     implicit none
    
!     integer :: k, i, n=10
!     real :: r
!     integer, dimension(8) :: values 
!     ! Declare an assumed shape, dynamic array
!     integer, dimension(:), allocatable :: seed

!     integer :: resl = 0
    
!     ! gfortran subroutine to return date and time information 
!     ! from the real time system clock. Works down to milliseconds 
!     ! and stores the eight return values in array values.
!     call date_and_time(VALUES=values)
    
!     ! restart the state of the pseudorandom number generator
!     ! k = minimum size of seed (12 on my system)
!     call random_seed(size=k)
    
!     ! allocate memory to seed
!     allocate(seed(k))
    
!     ! assign information in values to seed
!     seed(:) = values(:)
    
!     ! seed the random number generator
!     call random_seed(put=seed)
    
!     do while (resl < 1 .or. resl > 9)
!         call random_number(r)
!         resl = r * 10        
!     end do

!     print *, resl

!     ! do i=1,n
!     !     call random_number(r)
!     !     resl = r * 10
!     !     resl = resl
!     !     print *, resl
!     ! end do
    
!     end program randomEG

program test_rand
integer,parameter :: seed = 86456

call srand(seed)

print *, rand(), rand(), rand(), rand()
! print *, rand(seed), rand(), rand(), rand()

end program test_rand