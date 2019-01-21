identification division.
program-id. conv.
environment division.
input-output section.
data division.
file section.

working-storage section.
77 indexVal     pic 9.
77 lastVal      pic 9(8).
77 currVal      pic 9(8).

linkage section.
01 romanNumStr.
    02 char     pic x(1) occurs 30 times.

77 errorType    pic 9 usage is computational-3.
77 decimalNum   pic 9(8) usage is computational.

procedure division using romanNumStr, errorType, decimalNum.
    
    move zero to decimalNum.
    move 1001 to lastVal.
    move 1 to indexVal.
    perform toDecimalNum until romanNumStr(indexVal:1) is equal to " "

    move 1 to errorType.
    goback.

toDecimalNum.
    
    evaluate romanNumStr(indexVal:1)
    
        when 'i' move 1 to currVal 
        when 'v' move 5 to currVal
        when 'x' move 10 to currVal
        when 'l' move 50 to currVal
        when 'c' move 100 to currVal
        when 'd' move 500 to currVal
        when 'm' move 1000 to currVal 
        when other 
            display "illegal roman numeral"
            move 2 to errorType
            goback.

    compute decimalNum = decimalNum + currVal.
    compute indexVal = indexVal + 1.
    if currVal is greater than lastVal
        compute decimalNum = decimalNum - (2 * lastVal)
    move currVal to lastVal.

