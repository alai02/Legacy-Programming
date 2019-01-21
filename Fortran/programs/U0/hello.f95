program helloprogram
    implicit none

    real :: randnum
    integer, allocatable :: seed(:)
    integer :: n, i, result
    integer :: values(1:8)

    call date_and_time(values=values)
    call random_seed(size = n)
    allocate(seed(1:n))
    seed(:) = values(8)
    call random_seed(put=seed)

    do i = 1, 30

        call random_number(randnum)
        result = floor(9*randnum) +1
        write (*,*) "num: ", result
        
        ! if ( (result > 0 .and. result < 10 )) then
        !     write (*,*) "num: ", result
        ! end if
    end do

end program
