
-- CIS-3190 A2 - Word Jumble
-- Author: Alex Lai
-- Student Number: 0920158
-- Email: alai02@uoguelph.ca

-- This is a program called Word Jumble that lets a user enter jumbed words
-- and displays words in a dictionary that are anagrams of the characters.
-- This program uses a dictionary called canadian-english-small found on the SOCS servers
-- The user must enter character strings of length 6 or less

-- Ada imports for various string and object functionality
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Containers.Ordered_Sets;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with ada.strings.fixed; use ada.strings.fixed;

-- Program where a user can enter any amount of words and have the option to exit the program
-- The character strings will be used to find english words in a dictionary
procedure solveJumble is

    -- Ord_Set - A package import to use the Ordered_Set container to store the dictionary words in
    package Ord_Set is new Ada.Containers.Ordered_Sets(unbounded_string); use Ord_Set;
    -- numWords - An integer representing the amount of words a user enters
    -- numAnagrams - An integer representing the number of anagrams possible for a character string
    numWords : integer := 1;
    numAnagrams : integer;
    -- wordsArray - A user defined type for variable length array of unbounded strings for storing words
    -- wordsList - A fixed size array of strings in which to store the words entered by the user
    -- dictionaryList - A set that uses the Ordered_Sets package to store the words of the dictionary
    type wordsArray is array (positive range <>) of unbounded_string;
    wordsList : wordsArray(1 .. 100);
    dictionaryList : set;

    -- procedure to obtain user input for the set of jumbles
    -- wordsList - A fixed size array list in which to store the words that is empty
    -- numWords - A integer is incremented for each word entered
    procedure inputJumble(wordsList : in out wordsArray; numWords : in out integer) is
        -- wordStr - A string variable that will be written to every time a user enters a word
        wordStr : unbounded_string;
    begin
        -- Instruct user to enter words and give instructions to quit
        put_line("Enter jumbled words (each word on a new line, enter twice to end input)");
        -- Loop until user presses enter twice, wordStr will be an empty string
        loop
            -- Get user input and store in wordStr
            get_line(wordStr);
            exit when Index_Non_Blank(wordStr) = 0;            
            if length(wordStr) > 6 then
                -- Do not add word to list if longer than 6 characters
                put_line("ERROR: cannot enter more than 6 characters");
            else
                -- If user enters good input, add wordStr to list and increment number of words
                wordsList(numWords) := wordStr;
                numWords := numWords + 1;
            end if;
        end loop;
            -- decrement num words count when user completes input
            numWords := numWords - 1;
    end inputJumble;

    -- Function to get the number of anagrams for a word
    -- Uses factorial of the input to get number of anagrams possible
    -- Returns the factorial of wordLen as an integer 
    -- wordLen - An integer representing the length of the word
    function factorial(wordLen : integer) return integer is
        factorialNum : integer := 1;
    begin
        -- Only calculate factorial if greater than 2 since factorial of 0 and 1 is 1
        if wordLen < 2 then
            return factorialNum;
        end if;
        -- Loop to calculate the factorial of a number
        for i in 1 .. wordLen loop
            factorialNum := factorialNum * i;
        end loop;
        return factorialNum;
    end factorial;

    -- Function that generates anagrams from jumbled word, returns the list of anagrams
    -- numAnagrams - An integer representing the number of possible anagrams for the wordStr
    -- wordStr - An unbounded_string containing characters in which to generate the anagrams of
    function generateAnagram(numAnagrams : integer; wordStr: in out unbounded_string) return wordsArray is
        -- index - integer count of the current index for the wordsArray
        -- anagramsList - A list of words of type wordsArray that is the size of the number of anagrams
        index : integer := 1;
        anagramsList : wordsArray(1..numAnagrams);

        -- Procedure to swap 2 characters in an unbounded string
        -- i - the first index of the character to be swapped
        -- j - the second index of the character to be swapped
        procedure swap(wordStr : in out unbounded_string; i : in integer; j : in integer) is
            -- tempChar - A character to temporarily store the jth character
            -- tempStr - A temp fixed length sting in order to swap characters of unbounded string
            tempChar : character;
            tempStr : string := To_String(wordStr);
        begin
            tempChar := tempStr(j);
            tempStr(j) := tempStr(i);
            tempStr(i) := tempChar;
            wordStr := To_Unbounded_String(tempStr);
        end swap;

        -- Procedure to recursivly add anagrams of a character string to a list
        -- wordStr - A character string used to get anagrams of
        -- position - An integer representing the current index of the string for swapping characters
        procedure permutate(wordStr : in out unbounded_string; position : in integer) is
        begin
            -- Add wordStr to list of anagrams when position reaches the length
            if position = length(wordStr) then
                -- Add wordStr to list only if a duplicate already exists
                for i in 1 .. index loop
                    if wordStr = anagramsList(i) then
                        return;
                    end if;
                end loop;
                anagramsList(index) := wordStr;
                index := index +1;
                return;
            else
                -- simple recursive permutation function
                for i in position .. length(wordStr) loop
                    swap(wordStr, position, i);
                    permutate(wordStr, position +1);
                    swap(wordStr, position, i);
                end loop;
            end if;
        end permutate;

    begin
        -- call function permutate to generate all permutations        
        permutate(wordStr, 1);
        return anagramsList;
    end generateAnagram;

    -- Procedure that builds a dictionary to search for the anagrams in
    -- dictionaryList - A set data structure in which to store the words
    procedure buildLEXICON(dictionaryList : in out set) is
        -- dictionaryWord - A string to get each word in the file
        -- filePtr - A file type used to point to the file location
        dictionaryWord : unbounded_string;
        filePtr : file_type;        
    begin
        -- Opens the file of the dictionary
        open(filePtr, in_file, "canadian-english-small");
        -- open(filePtr, in_file, "/usr/share/dict/canadian-english-small");
        -- loop until end of file, inserting each word to dictionary
        loop
            exit when end_of_file(filePtr);
            get_line(filePtr, dictionaryWord);
            dictionaryList.insert(dictionaryWord);
        end loop;
        -- close the file pointer
        close(filePtr);
    end buildLEXICON;

    -- Procedure to search for the anagrams in a dictionary, printing all results
    -- numAnagrams - An integer for the size of the anagrams list
    -- anagramsList - A wordsArray object containing the anagrams
    -- dictionaryList - A set object containing words in a dictionary
    procedure findAnagram(numAnagrams : in integer; anagramsList : in wordsArray; dictionaryList : in set) is 
    begin
        -- loop through each anagram and printing the word if found in the dictionary
        for i in 1 .. numAnagrams loop
            if contains(dictionaryList, anagramsList(i)) then
                put(anagramsList(i));                
            end if;
        end loop;
    end findAnagram;
    
begin

    put_line("Ada A2 Word Jumble Program");
    put_line("--------------------------");
    
    -- call buildLEXICON to populate dictionaryList
    buildLEXICON(dictionaryList);

    -- call inputJumble to get user input and fill list of words
    inputJumble(wordsList, numWords);

    -- loop to get the anagrams for each word entered
    for i in 1 .. numWords loop
        -- get number of anagrams from factorial function
        numAnagrams := factorial(length(wordsList(i)));
        -- declare block to create an anagrams list with size dynamic size
        declare
            anagramsList : wordsArray := generateAnagram(numAnagrams, wordsList(i));
        begin
            -- call findAnagram to search the dictionary with the list of anagrams
            findAnagram(numAnagrams, anagramsList, dictionaryList);
        end;
    end loop;

end solveJumble;