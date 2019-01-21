with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.unbounded; use Ada.Strings.unbounded;
with Ada.Strings.unbounded.text_io; use Ada.Strings.unbounded.text_io;
with ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure scope is
   n: integer;

   procedure A(x: in integer) is
      z: float;

      function B(y: in integer) return float is
         n: float;
      begin
         put_line("Enter a real: ");
         get(n);
         return n * float(y);
      end B;

   begin
      z := B(x);
      put_line("Answer = ");
      put(z,2,4,0);
   end A;

begin
   put_line("Enter an integer: ");
   get(n);
   A(n);
end scope;



with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure fibfunc is

   function fibonacci(n : in integer) return integer is
      f1, f2, fib : integer;
   begin
      f1 := 1;
      f2 := 1;
      for i in 3..n loop
         fib := f1 + f2;
         f1 := f2;
         f2 := fib;
      end loop;
      return fib;
   end fibonacci;

   fib : integer;
   num : integer;

begin
   put_line("Which Fibonacci number ? ");
   get(num);

   fib := fibonacci(num);
   put_line("Fibonacci number " & integer'image(num) & " is " & integer'image(fib));

end fibfunc;