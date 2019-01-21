program time
	real :: ltyr, ltmin, dist, elapse
	integer :: minute, second
	!
	! Program to calculate the time it takes for light
	! to reach Earth from the sun. Light travels 9.46x10^12 km
	! in one year (365.25 days) The distance between the Sun
	! and Earth is approx. 150,000,000 km.ó
	!
	! ltyr distance travelled by light in one year in km
	! ltmin distance travelled by light in one minute in km
	! dist distance from sun to earth in km
	! elapse time taken to travel a distance dist in minutes
	! minute integer number part of elapse
	! second integer number of seconds equivalent to fractional
	! part of elapse
	!
	ltyr = 9.45*10.0**12.00
	ltmin = ltyr/(365.25*24.0*60.0)
	dist = 150.0*10**6
	elapse = dist / ltmin
	minute = elapse
	second = (elapse-minute)*60
	write (*,*) 'Light takes ',minute,' minutes ',second, ' seconds'
	write (*,*) 'to reach earth from the sun'
end
