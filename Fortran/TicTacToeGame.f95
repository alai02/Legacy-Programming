! Name: Alex Lai, Student Number: 0920158, Email: alai02@uoguelph.ca
! This is a program that a user can play the computer in a game of tic-tac-toe
program tictactoe
    implicit none
    write (*,'(a)') " Play TIC-TAC-TOE. ENTER 1-9 TO PlAY"
    write (*,*) "	1 | 2 | 3 "
    write (*,*) "	---+---+---"
    write (*,*) "	4 | 5 | 6 "
    write (*,*) "	---+---+---"
    write (*,*) "	7 | 8 | 9 "
    ! Call the game loop
    call playTicTacToe()
end program tictactoe

! function to check input of a row, col, or diagonal. return true if all elements are the same and not empty
logical function same(elem1, elem2, elem3)
    implicit none
    ! Declare inputer parameters
    character(1), intent(in) :: elem1, elem2, elem3
    ! check if elements are the same
    if (elem1 == elem2 .and. elem2 == elem3) then
        same = .true.
    else
        same = .false.
    end if
    ! ensure spaces are not empty
    if (elem1 == ' ') then
        same = .false.
    end if
end function same

! Check to make sure human player cannot make a play in the square that is already occupied
logical function chkplay(tictac, move)
    implicit none
    ! Declare types of parameters passed in
    character(1), intent(in), dimension(3,3) :: tictac   
    integer, intent(in) :: move
    ! Check if square is empty at each index
    if (move .eq. 1 .and. tictac(1,1) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 2 .and. tictac(1,2) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 3 .and. tictac(1,3) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 4 .and. tictac(2,1) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 5 .and. tictac(2,2) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 6 .and. tictac(2,3) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 7 .and. tictac(3,1) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 8 .and. tictac(3,2) .eq. " ") then
        chkplay = .true.
    else if (move .eq. 9 .and. tictac(3,3) .eq. " ") then
        chkplay = .true.
    else
        chkplay = .false.
    end if
end function chkplay

! Function to get the index from 1-9 from a row and column pair of the matric
integer function getFreeIndex(row, col)
    implicit none
    ! Declare types of input params passed in
    integer, intent(in) :: row, col
    ! Return the corresponding index for the row col index
    if (row .eq. 1 .and. col .eq. 1) then
        getFreeIndex = 1
    else if (row .eq. 1 .and. col .eq. 2) then
        getFreeIndex = 2
    else if (row .eq. 1 .and. col .eq. 3) then
        getFreeIndex = 3
    else if (row .eq. 2 .and. col .eq. 1) then
        getFreeIndex = 4
    else if (row .eq. 2 .and. col .eq. 2) then
        getFreeIndex = 5
    else if (row .eq. 2 .and. col .eq. 3) then
        getFreeIndex = 6
    else if (row .eq. 3 .and. col .eq. 1) then
        getFreeIndex = 7
    else if (row .eq. 3 .and. col .eq. 2) then
        getFreeIndex = 8
    else if (row .eq. 3 .and. col .eq. 3) then
        getFreeIndex = 9
    end if
end function getFreeIndex

! Function to get human move, accepts user input: integer from 1 - 9
integer function getMove()
    implicit none
    ! Declare local variables
    ! move - the players move choice 
    ! moveError - A eror checker which sets move to zero on bad user input
    ! validMove - a boolean to determine 
    integer :: move, moveError
    logical :: validMove = .false.
    write (*,'(a)') " Your move?"
    read(*,'(i10)', iostat=moveError) move
    ! Loop until user enters a valid move
    do while (validMove .eqv. .false.)
        if (move < 1 .or. move > 9) then
            write (*,'(a)') " Enter a number from 1 - 9"
            read(*,'(i10)', iostat=moveError) move
        else
            validMove = .true.
        end if
    end do
    getMove = move
end function getMove

! Values of sqaure characters: X = 1, O = 4, ' ' = 0
integer function getCharVal(char)
    implicit none
    ! Declare input parameters
    character(1), intent(in) :: char
    ! Player symbol constants
    character(1), parameter :: userChar = 'X', compChar = 'O'
    if (char == userChar) then
        getCharVal = 1
    else if (char == compChar) then
        getCharVal = 4
    else
        getCharVal = 0
    end if
end function getCharVal

! Function to print out the tic tac toe board
subroutine showBoard(tictac)
    implicit none
    ! Declare types of the input parameter
    character(1), intent(in), dimension(3, 3) :: tictac
    integer :: i
    do i = 1, 3 ! Loop through the rows of the board
        write (*,*) " ", tictac(i,1), " | ", tictac(i,2), " | ", tictac(i,3), " "
        if (i < 3) then
            write (*,*) "---+---+---"
        end if
    end do
    return
end subroutine showBoard

! subroutine to play the game
subroutine playTicTacToe()
    implicit none
    ! External function definitions used
    logical, external :: chkplay
    integer, external :: getMove
    ! Declare local variables
    logical :: over = .false., isValidUserMove = .false.
    integer :: userMove
    character :: winner
    character(1), dimension(3,3) :: tictac
    character(1), parameter :: userChar = 'X', compChar = 'O', drawChar = 'D'
    ! Initialize empty board
    integer :: i, j
    do i = 1, 3
        do j = 1, 3
            tictac(i, j) = " "
        end do
    end do
        
    ! Loop until exit when chkovr is true
    do while (over .eqv. .false.)
        ! Users turn
        isValidUserMove = .false.
        do while(isValidUserMove .eqv. .false.)
            ! complete the human move by calling getMove()
            userMove = getMove()
            ! check if valid user move by calling chkplay()
            isValidUserMove = chkplay(tictac, userMove)
            if (isValidUserMove .eqv. .false.) then
                write (*,'(a)') "Cannot play here, enter an empty square"
            end if
        end do
        ! Place char on board
        call placeMove(tictac, userMove, userChar)
        ! display the board by calling showBoard()
        write (*,'(a)') "After your move..."
        call showBoard(tictac)
        ! check to see if user has won by calling chkovr()
        call chkovr(tictac, over, winner)
        ! Dont let computer choose if game ends on user turn
        if (over .eqv. .false.) then
            ! Computer plays
            call pickMove(tictac)
            ! display the board by calling showBoard()
            write (*,'(a)') "After my move..."
            call showBoard(tictac)
            ! check to see if computer has won by calling chkovr()
            call chkovr(tictac, over, winner)
        end if
    ! Exit if over is true
    end do
    ! Determine and output who won the game
    write(*,'(a)') "The game is over"
    if (winner == compChar) then
        write(*,'(a)') "Computer wins!"
    else if (winner == userChar) then
        write(*,'(a)') "User wins!"
    else if (winner == drawChar) then
        write (*,'(a)') "It's a draw!"
    else 
        write (*,'(a)') "Error occured!", winner
    end if
    return
end subroutine playTicTacToe

! Place the symbol of user and computers move on the board
subroutine placeMove(tictac, moveIndex, moveToPlace)
    implicit none
    ! Declare input parameters
    integer, intent(in) :: moveIndex
    character(1), intent(in) :: moveToPlace
    character(1), intent(inout), dimension(3,3) :: tictac
    ! place the move at the corresponding index on the board
    if (moveIndex .eq. 1) then
        tictac(1,1) = moveToPlace
    else if (moveIndex .eq. 2) then
        tictac(1,2) = moveToPlace
    else if (moveIndex .eq. 3) then
        tictac(1,3) = moveToPlace
    else if (moveIndex .eq. 4) then
        tictac(2,1) = moveToPlace
    else if (moveIndex .eq. 5) then
        tictac(2,2) = moveToPlace
    else if (moveIndex .eq. 6) then
        tictac(2,3) = moveToPlace
    else if (moveIndex .eq. 7) then
        tictac(3,1) = moveToPlace
    else if (moveIndex .eq. 8) then
        tictac(3,2) = moveToPlace
    else if (moveIndex .eq. 9) then
        tictac(3,3) = moveToPlace
    end if
    return
end subroutine placeMove

! Check if tic-tac-toe is over and determine a winner (if any)
subroutine chkovr(tictac, over, winner)
    implicit none
    ! Define the type of input parameters
    character(1), intent(in), dimension(3,3) :: tictac
    ! Output type arguement definitions
    !	over - Indicates whether or not the game is over
    !	winner - Indicates the winner (X or O) or a draw (D)
    logical, intent(out) :: over
    character(1), intent(out) :: winner
    ! subroutine constants
    character(1), parameter :: blankChar = ' ', drawChar = 'D'
    ! Define external functions used
    logical, external :: same, chkplay
    ! Local variables for iterators and sum of the diagonals
    logical :: diag1, diag2 
    integer :: rowItr, colItr
    ! Assume game is over at start
    over = .true.
    ! Check rows for a winner
    do rowItr = 1, 3
        if (same(tictac(rowItr,1), tictac(rowItr,2), tictac(rowItr,3))) then
            winner = tictac(rowItr,1)
            return
        end if
    end do
    ! No winner by rows, check colums for a winner
    do colItr = 1, 3
        if (same(tictac(1,colItr), tictac(2,colItr), tictac(3,colItr)) ) then
            winner = tictac(1,colItr)
            return
        end if
    end do
    ! No winner by rows or columns, check diagonals for a winner
    diag1 = same(tictac(1,1), tictac(2,2), tictac(3,3))
    diag2 = same(tictac(1,3), tictac(2,2), tictac(3,1))
    ! check for winner in diagonals
    if ((diag1 .eqv. .true.) .or. (diag2 .eqv. .true.)) then
        winner = tictac(2,2)
        return
    end if
    ! No winner at all. see if game is a draw
    ! Check each row for an empty space
    do rowItr = 1, 3
        do colItr = 1, 3
            if (tictac(rowItr, colItr) .eq. blankChar) then
                over = .false.
                return
            end if
        end do
    end do
    ! No blank found, game is a draw
    winner = drawChar
    return
end subroutine chkovr

! Function that performs the computers move, it check sums of the rows, cols, diagonals
! if sum = 8: place the wining move, if sum = 2: place the blocking move, else place a random move
subroutine pickMove(tictac)
    implicit none
    ! Define type for input parameters
    character(1), intent(inout), dimension(3,3) :: tictac
    ! Declare external functions used
    logical, external :: chkplay
    integer, external :: getCharVal, getFreeIndex, randomNumer
    ! subroutine constants
    character(1), parameter :: blankChar = ' ', compChar = 'O'
    ! Local variables, rowItr = row index, colItr = column index 
    integer :: i, rowItr, colItr, move, sum
    ! declare random number variables and set the seed
    logical :: validRandomNum
    real :: randnum
    integer, allocatable :: seed(:)
    integer :: n, result, values(1:8)
    call date_and_time(values=values)
    call random_seed(size = n)
    allocate(seed(1:n))
    seed(:) = values(8)
    call random_seed(put=seed)

    ! Check for optimal winning moves
    do rowItr = 1, 3 ! Check for winning move in rows
        sum = getCharVal(tictac(rowItr,1)) + getCharVal(tictac(rowItr,2)) + getCharVal(tictac(rowItr,3))
        if (sum .eq. 8) then ! Winning move
            do i = 1, 3
                if (tictac(rowItr, i) == blankChar) then
                    move = getFreeIndex(rowItr, i)
                    call placeMove(tictac, move, compChar)
                    return
                end if
            end do            
        end if
    end do
    ! Check for winning move in cols
    do colItr = 1, 3
        sum = getCharVal(tictac(1,colItr)) + getCharVal(tictac(2,colItr)) + getCharVal(tictac(3,colItr))
        if (sum .eq. 8) then ! Winning move
            do i = 1, 3
                if (tictac(i, colItr) == blankChar) then
                    move = getFreeIndex(i, colItr)
                    call placeMove(tictac, move, compChar)
                    return
                end if
            end do
        end if
    end do
    ! Check for winning move in first diagonal
    sum = getCharVal(tictac(1,1)) + getCharVal(tictac(2,2)) + getCharVal(tictac(3,3))
    if (sum .eq. 8) then ! Winning move
        do i = 1, 3
            if (tictac(i, i) == blankChar) then
                move = getFreeIndex(i, i)
                call placeMove(tictac, move, compChar)
                return
            end if
        end do        
    end if
    ! Check for winning move in second diagonal
    sum = getCharVal(tictac(1,3)) + getCharVal(tictac(2,2)) + getCharVal(tictac(3,1))
    if (sum .eq. 8) then ! Winning move
        if (tictac(1, 3) == blankChar) then
            call placeMove(tictac, 3, compChar)
        else if (tictac(2, 2) == blankChar) then
            call placeMove(tictac, 5, compChar)
        else
            call placeMove(tictac, 7, compChar)
        end if
        return
    end if
    ! Check for block in rows
    do rowItr = 1, 3
        sum = getCharVal(tictac(rowItr,1)) + getCharVal(tictac(rowItr,2)) + getCharVal(tictac(rowItr,3))
        if (sum .eq. 2) then ! Blocking move
            do i = 1, 3
                if (tictac(rowItr, i) == blankChar) then
                    move = getFreeIndex(rowItr, i)
                    call placeMove(tictac, move, compChar)
                    return
                end if
            end do            
        end if
    end do
    ! Check for block in cols
    do colItr = 1, 3 
        sum = getCharVal(tictac(1,colItr)) + getCharVal(tictac(2,colItr)) + getCharVal(tictac(3,colItr))
        if (sum .eq. 2) then ! Blocking move
            do i = 1, 3
                if (tictac(i, colItr) == blankChar) then
                    move = getFreeIndex(i, colItr)
                    call placeMove(tictac, move, compChar)
                    return
                end if
            end do            
        end if
    end do
    ! Check for block in first diagonal
    sum = getCharVal(tictac(1,1)) + getCharVal(tictac(2,2)) + getCharVal(tictac(3,3))
    if (sum .eq. 2) then ! Blocking move
        do i = 1, 3
            if (tictac(i, i) == blankChar) then
                move = getFreeIndex(i, i)
                call placeMove(tictac, move, compChar)
                return
            end if
        end do        
    end if
    ! Check for block in second diagonal
    sum = getCharVal(tictac(1,3)) + getCharVal(tictac(2,2)) + getCharVal(tictac(3,1))
    if (sum .eq. 2) then ! Blocking move
        if (tictac(1, 3) == blankChar) then
            call placeMove(tictac, 3, compChar)
        else if (tictac(2, 2) == blankChar) then
            call placeMove(tictac, 5, compChar)
        else
            call placeMove(tictac, 7, compChar)
        end if
        return
    end if

    ! No optimal moves, placing a random move
    validRandomNum = .false.
    ! No optimal spots found, placing in random square
    do while (validRandomNum .eqv. .false.)
        ! get the random number
        call random_number(randnum)
        result = floor(9*randnum) +1
        ! make sure number is 
        if ((result > 0) .and. (result < 10)) then
            validRandomNum = .true.
        end if
        ! make sure spot on board is not taken
        if (chkplay(tictac, result) .eqv. .false.) then
            validRandomNum = .false.
        end if
    end do
    ! place the valid move on the board
    call placeMove(tictac, result, compChar)
    return
end subroutine pickMove
