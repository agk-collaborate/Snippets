
// Linear interpolation function.
function lerp(_f1#, _f2#, _factor#)
	if _factor# <= 0.0
		exitfunction _f1#
	elseif _factor# >= 1.0
		exitfunction _f2#
	else
		exitfunction ( ( 1.0 - _factor# ) * _f1# ) + ( _factor# * _f2# )
	endif
endfunction 0.0
