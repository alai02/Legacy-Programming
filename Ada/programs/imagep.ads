with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with ada.directories; use ada.directories;

package imageP is

   type pixelMatrix is array(1..200,1..300) of integer;
 
   type image is 
      record
         pixel : pixelMatrix; 
         dx : integer;
         dy : integer;
      end record;
 
   procedure readImage(img: out image; fname: in unbounded_string);
   function meanFilter(img: in image) return image;
   procedure writeImage(img: in image; fname: in unbounded_string);

end imageP;