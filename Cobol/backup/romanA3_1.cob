identification division.
program-id. romanA3_1.
environment division.
input-output section.
file-control.    
    select inputFile assign to dynamic fileName organization is line sequential.

data division.
file section.
fd inputFile.
    01 roman-num.
        03 str pic x(80).

working-storage section.

01 romanNumStr.
    02 char pic x(1) occurs 30 times.
    
77 inputType    pic 9.
77 eof-switch   pic 9 value 1.
77 fileName     pic x(30).

77 errorType    pic 9 usage is computational-3.
77 decimalNum   pic 9(8) usage is computational.

procedure division.
    
    perform menuProcedure until inputType is equal to 3.
    stop run.

menuProcedure.
    display "Select an input option".
    display "(1) for standard input".
    display "(2) for file input".
    display "(3) to quit".
    accept inputType.

    evaluate inputType
        when 1 perform stdProcedure
        when 2 perform fileProcedure
        when 3 stop run
        when other display "Invalid input".

printProcedure.
    display "     roman number equivalents".
    display "----------------------------------".
    display "   roman number        dec. equiv.".
    display "----------------------------------".

stdProcedure.
    perform printProcedure.
    accept romanNumStr.
    call "conv" using romanNumStr, errorType, decimalNum.
    display romanNumStr, decimalNum.

fileProcedure.
    perform printProcedure.
    
    display "Enter the path of the file: ".
    accept fileName.
    open input inputFile. 
    perform readFile until eof-switch = 0. 
    close inputFile.

readFile.
    read inputFile into romanNumStr
        at end move zero to eof-switch
    end-read.

    call "conv" using romanNumStr, errorType, decimalNum.
    display romanNumStr, decimalNum.

