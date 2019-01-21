program IsAnythingWrong
implicit none

! This program will compile and run
! It does not product the correct result because...
! the cos and sin functions use radians not degreese

real :: a, b, c, theta

write (*,*) 'Enter the length of the hypotenuse C: '
read (*,*) c

write (*,*) 'Enter the angle theta in degrees: '
read (*,*) theta

a = c * cos(theta)
b = c * sin(theta)

write (*,*) 'The length of the adjacent side is ', a
write (*,*) 'The length of the opposite side is ', b

write (*,*) 'The length of the adjacent side is ', (c * 0.86)
write (*,*) 'The length of the adjacent side is ', cos(theta)

end program IsAnythingWrong
