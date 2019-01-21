with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

procedure Hello is
    outfp : file_type;
    j : integer := 0;
    k : integer := 1;
    l : string(1..8) := "........";
    board : is array(1..8,1..8) of characters;

begin
    -- Hello world in ada
    put_line("Hello world!");

    create(outfp, out_file, "queensR.txt");

    for i in 1..length(chessBoard) loop
        put(element(chessBoard,i) & ".");
    end loop;

    if is_open(outfp) then

        put_line(outfp, "Queens Recursive");

        put(chessBoard);

        close(outfp);
    end if;

end Hello;