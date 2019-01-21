program WaveBreaking
implicit none

! T = wave period in seconds
! Hb = wave height at breaking in cm
! m = beach slope
! B = inshore parameter
! g = gravitational acceleration cm sec squared

real, parameter :: g=981
real :: T, m, Hb, B
character(len=12) :: type

write (*,*) "Wave Breaking program"
write (*,*) "Enter the wave height"
read (*,*) Hb

write (*,*) "Enter the wave period"
read (*,*) T

write (*,*) "Enter the beach slope"
read (*,*) m

B = (Hb / ( g * ( m * (T**2) ) ) )

if (B < 0.003) then
	type = "surging"
else if (B > 0.068) then
	type = "spilling"
else
	type = "plunging"

end if

write (*,*) "The breaking type is: ", type

end program
