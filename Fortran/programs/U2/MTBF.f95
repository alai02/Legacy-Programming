
! Mean-time-between-failure
! Total runtime of asset divided by number of failures
! m = total survival hours / number of failures
! total survivor hours = sum of number of components * time to failure

program MTBF
    implicit none

    integer :: num_components = 0, hours_to_test, list_length

    integer :: i, j, MTBF_value, ts_hours = 0, num_failures = 0
    integer, dimension(100, 2) :: components_list

    integer :: component_count = 0

    write (*,*) "Enter the number of components to test"
    read (*,*) num_components

    write (*,*) "Enter the number hours to test each component"
    read (*,*) hours_to_test

    write (*,*) "Enter a list of components which fail, and their fail times (-1 for no failure)"

    do i = 1, num_components

        if (component_count >= num_components) then
            list_length = i - 1
            exit
        end if

        write (*,*) "format: x y"
        read (*,*) components_list(i, 1), components_list(i, 2)

        component_count = component_count + components_list(i, 1)
    end do
    
    do j = 1, list_length
        
        if ( components_list(j, 2) >= 0 ) then
            num_failures = num_failures + components_list(j, 1)
        end if

        if ( components_list(j, 2) == -1 ) then
            ts_hours = ts_hours + (hours_to_test * components_list(j, 1) )
        else
            ts_hours = ts_hours + ( components_list(j, 1) * components_list(j, 2) )
        end if
            
    end do

    MTBF_value = ts_hours / num_failures

    write (*,*) "The MTBF value is: ", MTBF_value, " hours"

end program MTBF
