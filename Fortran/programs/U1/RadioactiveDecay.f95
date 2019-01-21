program RadioactiveDecay
implicit none

! N = amount of material at time t, any convenient units
! N0 = the initial amount of material, same units as N
! lambda = decay constant
! t = time, any convient units
! T = half-life, same units as t
! half life is the required time for half of the material to decay

! lambda = ln(2)/T

real :: N, N0=0.00, lambda
real, parameter :: e=2.718281828
real, parameter :: x=2.0
integer :: t, T0

write (*,*) "Welcome to my radioactive decay program"
write (*,*) "Enter the half life of the isotope: "
read (*,*) T0
write (*,*) "Enter the amount of grams you want left"
read (*,*) N
write (*,*) "Enter the number of days"
read (*,*) t

lambda = log(x) / T0

N0 = N * ( e**( lambda * t ) )

write (*,*) "A radioactive isotope with a half-life of "
write (*,*) T0, " days"
write (*,*) "If you want ", N
write (*,*) "grams at the end of ", t
write (*,*) "days, "

write (*,*) "you will need to start with: ", N0
write (*,*) " grams"

END PROGRAM
