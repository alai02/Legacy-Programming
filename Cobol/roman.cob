*> CIS-3190 A3 - Roman Numeral Converter
*> Author: Alex Lai
*> Student Number: 0920158
*> Email: alai02@uoguelph.ca

*> Program to convert roman numerals to their decimal equivalents
*> Uses subroutine in file conv.cob
identification division.
program-id. romanA3_1.
environment division.
input-output section.
*> Declare file type and assign value
file-control.    
    select filePtr assign to dynamic fileName organization is line sequential
    file status is file-status.
*> Declare type for file pointer with length of line
data division.
file section.
fd filePtr.
    01 lineBuffer.
        03 char pic x(20).
working-storage section.
*> Array to store user input and the roman numeral
01 inputArray.
    02 char     pic x(20).
    *>  occurs 20 times.
01 romanNumStr.
    02 char     pic x(20).
*> Declare status to check for valid file
01 file-status.
    05 status-flat1 pic x.
    05 status-flag2 pic x.

77 inputType    pic 9.
77 eof-switch   pic 9 value 1.
77 fileName     pic x(30).
77 errorFlag    pic 9 usage is comp-3.
77 romanNumD    pic 9(8) usage is comp.
77 formattedNum pic z(9).

*> Main procedure to display welcome and loop menu until user quits
procedure division.
    display "---Roman Numeral Converter program---"
    perform menuProcedure until inputType is equal to 3.
    stop run.

*> Procedure to prompt user with a menu and call related procedure
menuProcedure.
    display "---Input options---".
    display "(1) std input, (2) file input, (3) quit".
    accept inputType.
    evaluate inputType
        when 1 perform stdinProcedure
        when 2 perform fileProcedure
        when 3 stop run
        when other display "Invalid input".
    move 1 to errorFlag.
    move 1 to eof-switch.

*> Procedure to display header for readability
displayProcedure.
    display "   roman number equivalents".
    display "------------------------------".
    display "roman number       dec. equiv.".
    display "------------------------------".
end-perform.

*> Procedure to convert a roman numeral the decimal form
*> First convert to lowercase, call conversion subroutine and print result
convertProcedure.
    move function lower-case(inputArray) to romanNumStr.
    call "conv" using romanNumStr, errorFlag, romanNumD.
    perform printNumProcedure.

*> Procedure to print conversion if no error occured
*> Converts number to Z type to remove leading zeros
printNumProcedure.
    if (errorFlag is equal to 1) then
        move romanNumD to formattedNum
        display inputArray, formattedNum
    end-if.
    
*> Procedre to print header, accept user input and call convert
stdinProcedure.
    perform displayProcedure.
    accept inputArray.
    perform convertProcedure.

*> Procedure to get file from user and read it
*> Opens file and checks for error
*> Reads each line, displaying the result
fileProcedure.
    display "Enter the filepath: ".
    accept fileName.
    open input filePtr. 
    if file-status = '00' then
        perform displayProcedure
        perform readLineProcedure until eof-switch = 0
        close filePtr
    else
        display "Invalid file"
    end-if.

*> Procedure to read a line of a file
*> Calls function to convert input
readLineProcedure.
    read filePtr into inputArray
        at end move zero to eof-switch
    end-read.
    perform convertProcedure.

end program romanA3_1.
    