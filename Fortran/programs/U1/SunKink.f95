program SunKink
implicit none

! L = length of railway track
! dT = change in tempurature
! dL = change in rail length
! a = coefficient of linear expansion
! steel coefficient, a = 11e-6 degree celcius

real :: a, L, dT, dL, totalL

a = ( 11.00 * ( 10.0**(-6) ) )

write (*,*) "Enter the length of the railway track in meters"
read (*,*) L

write (*,*) "Enter the change in tempurature in degrees celcius"
read (*,*) dT

dL = a * L * dT

totalL = dL + L

write(*,*) "New railway length: ", totalL, "meters"

end program
