with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.Float_Text_IO; use ada.Float_Text_IO;
procedure convert is
    yards, feet, inches : integer;
    metres : float;
    conversion_factor : constant float := 39.37;
begin
    put("Number of metres: "); 
    get(metres);

    inches := integer (metres * conversion_factor);
    feet := inches / 12;
    inches := inches rem 12;
    yards := feet / 3;
    feet := feet rem 3;

    put(metres, aft=>2, exp=>0); put(" metres = ");
    put(yards); put(" yards,");
    put(feet, width => 2); put(" feet,");
    put(inches, width => 3); put(" inches"); 
    
    new_line;
end convert;