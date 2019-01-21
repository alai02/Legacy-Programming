identification division.
program-id. conv.
environment division.
input-output section.
data division.
file section.
*> Declare subroutines local variables
working-storage section.
77 indexVal     pic 99.
77 lastVal      pic 9(5).
77 currVal      pic 9(5).
*> Declare parameter types to match calling function
linkage section.
01 romanNumStr.
    02 char     pic x(1) occurs 20 times.
77 errorFlag    pic 9 usage is comp-3.
77 romanNumD    pic 9(8) usage is comp.

*> Subroutine to convert a roman numeral string to decimal number
*> Initializes local variable values and converts each letter to decimal representation
procedure division using romanNumStr, errorFlag, romanNumD.
    
    move zero to romanNumD.
    move 1 to indexVal.
    move 1001 to lastVal.
    perform toDecimalNum until romanNumStr(indexVal:1) is equal to " ".

    move 1 to errorFlag.
    goback.

*> Procedure to add letter value to decimal number representation
*> Adds corresponding weight to letter value and adds to result
*> If invalid error occurs, subroutine sets error flag and returns
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
            move 2 to errorFlag
            goback.
    compute romanNumD = romanNumD + currVal.
    compute indexVal = indexVal + 1.
    if (currVal > lastVal)
        compute romanNumD = romanNumD - (2 * lastVal)
    end-if.
    move currVal to lastVal.

