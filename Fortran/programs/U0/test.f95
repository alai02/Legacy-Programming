
program stripBlanks

   character (len=30) :: str, strip
   integer :: strL, i, ipos

   write (*,*) 'Enter a sentence: '
   read (*,'(a)') str
   strip = ' '

   strL = len_trim(str)
   ipos = 0
   do i = 1,strL
      if (str(i:i) /= ' ') then
         ipos = ipos + 1
         strip(ipos:ipos) = str(i:i)
      end if
   end do

   write (*,'(a)') str
   write (*,'(a)') strip

end program