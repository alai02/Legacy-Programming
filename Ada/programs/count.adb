with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure count is
    upperC, lowerC, blankC, punctC : integer := 0;
    ch : character;
begin
    put("Enter a sentence: "); 
    loop
        get(ch);
        if ch in 'a' .. 'z' then
            lowerC := lowerC + 1;
        elsif ch in 'A' .. 'Z' then
            upperC := upperC + 1;
        elsif ch = ' ' then
            blankC := blankC + 1;
        else
            punctC := punctC + 1;
        end if;
        
        exit when ch = '.';
    end loop;

    put("Uppercase characters = ");
    put(upperC, width => 1); new_line;
    put("Lowercase characters = ");
    put(lowerC, width => 1); new_line;
    put("Blank characters = ");
    put(blankC, width => 1); new_line;
    put("Punctuation characters = ");
    put(punctC, width => 1); new_line;
end count;