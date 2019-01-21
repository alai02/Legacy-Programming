PROGRAM DDB
implicit none
! D = deflection (in, m)
! P = central load (lbs, N)
! L = support span (in, m)
! E = modules of elasticity (psi, N/m^2)
! I = moment of inertia (in^4, m^4)
! bT = board thickness -> t
! bW = board width -> b
!contains

real, external :: moment
real :: I, D
I = moment()
call deflection(I, D)

write (*,*) "The deflection value is: ", D, " inches"
write (*,*) "the moment of inertia is: ", I, "in^4"

END PROGRAM DDB

REAL FUNCTION moment()
	implicit none
	real :: t, b, moment1
	write (*, *) "Enter the bard thinkness t"
	read (*,*) t
	write (*,*) "Enter the board width b"
	read (*,*) b
	moment1 = ( ( b * (t**3) ) / 12.0 )
	moment = moment1
END FUNCTION moment

SUBROUTINE deflection(I, D)
! implicit none
	real, intent(in) :: I
	real, intent(out) :: D
	real :: P, L, E
	write (*, *) "Enter the central load P"
	read (*,*) P
	write (*,*) "Enter the support span L"
	read (*,*) L
	write (*, *) "Enter the module of elasticity E(psi, N/m^2)"
	read (*,*) E
	D = ( P * (L**3) ) / ( 48.0 * E * I )
	return
END SUBROUTINE deflection
