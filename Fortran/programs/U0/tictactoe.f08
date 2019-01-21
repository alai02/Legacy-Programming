PROGRAM TICTACTOE
	IMPLICIT none
	character (len=1), DIMENSION(3,3) :: ticTac
	character :: winner

	SUBROUTINE CHKOVR(ticTac, over, winner)
		character (len=1), DIMENSION(3,3) :: ticTac
		character :: winner
		logical over

	END SUBROUTINE CHKOVR
END PROGRAM TICTACTOE

C CHKOVR(): Determines if there is a winner in a game of Tic-Tac-Toe.
C CHKPLAY(): Checks to make sure the human player cannot make a play in a square that is already occupied.
C Perform the following:
C 1. Complete a functioning program, tictactoe, which plays a game of Tic-Tac-Toe between
C a human and a computer.
C 2. Migrate the code for CHKOVR() and CHKPLAY() to F95/F2003 standards.
C 3. Implement any dependencies, eg. the function same().
C 4. Implement five functions playTicTacToe(), getMove(), pickMove(),
C chkplay(), and showBoard().
C 5. Test the program thoroughly.
C Subprograms dependencies:
C same(): A logical function which tests a row, column or diagonal returns a value of true if all three
C elements are the same (‘X’ or ‘O’); otherwise returns false.
C playTicTacToe(): Subroutine which plays the game. Assume one player is human and the other player is a
C computer. This subroutine would include the humans move, but not the computers move
C (which is obviously a little more complicated - see function computerMove() ).
C getMove(): Gets the humans move. The output from getMove() is a number from 1 to 9 representing
C the chosen square. Should validate player input.
C pickMove(): Performs the computers move. An algorithm for the computer is described below.
C chkplay(): Checks to make sure the human player cannot make a play in a square that is already occupied.
C showBoard(): Prints out the tic-tac-toe board, each time a player moves.

C to execute gfortran tictactoe.f77 -o exe
