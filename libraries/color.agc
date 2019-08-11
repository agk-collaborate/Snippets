/*
AUTHOR:
	IronManhood
	
DATE:
	last updated 08/11/2019
	
PURPOSE:
	Shared with the community.

DOCUMENTATION:
	A color library.

FUNCTIONS:
	t_Color <-- clr(_r, _g, _b, _a)
	void <-- clr_nullify(_clr ref as t_Color)
	
	t_Color <-- clr_randomRGB(_alpha)
	
	boolean <-- clr_Compare(_clr1 as t_Color, _clr2 as t_Color)
	boolean <-- clr_CompareSprite(_clr as t_Color, _sprID)
	
	void <-- clr_SetSpriteColor(_sprID as integer, _clr as t_Color)
	void <-- clr_SetTextColor(_txtID as integer, _clr as t_Color)
	void <-- clr_SetTextCharColor(_txtID as integer, _CharIndex, _clr as t_Color)
	
	string <-- clr_Str(_clr as t_Color)
	
	void <-- clr_swap(_clr1 ref as t_Color, _clr2 ref as t_Color)
	
	t_Color <-- clr_hsv2rgb(_h#, _s#, _v#, _a)
	float <-- clr_Hue(_clr as t_Color)
	
	float <-- clr_min_f(_v1#, _v2#)
	float <-- clr_max_f(_v1#, _v2#)
	float <-- clr_inrange_f(_val#, _min#, _max#)
	integer <-- clr_inrange_i(_val, _min, _max)
	
	t_Color <-- clr_MultiLerp(_clrArr as t_Color[], _factor#)
	t_Color <-- clr_MultiLerpRGB(_clrArr as t_Color[], _factor#, _alpha)
	t_Color <-- clr_baseLerp(_clr ref as t_Color, _clr_0 as t_Color, _clr_1 as t_Color, _factor#, _Alpha)
	
	integer <-- clr_ReplaceImageColor(_imgID, _clr1 as t_Color, _clr2 as t_Color)
	integer <-- clr_ReplaceColorInRange(_imgID, _clr1 as t_Color, _clr2 as t_Color, _range#)
	integer <-- clr_ReplaceColorInRangeImage(_copyTo_imgID, _copyFrom_imgID, _clr as t_Color, _range#)
	
EXAMPLE:

*/



type t_Color
	red as integer
	green as integer
	blue as integer
	alpha as integer
endtype








// Return a new color equal to the parameters.
function clr(_r, _g, _b, _a)
	_clr as t_Color
	_clr.red = _r
	_clr.green = _g
	_clr.blue = _b
	_clr.alpha = _a
endfunction _clr



// Set the parameter to 0.
function clr_nullify(_clr ref as t_Color)
	_clr.red = 0
	_clr.green = 0
	_clr.blue = 0
	_clr.alpha = 0
endfunction



// Return a random color.
function clr_randomRGB(_alpha)
	clr as t_Color
	clr.red = Random(0, 255)
	clr.green = Random(0, 255)
	clr.blue = Random(0, 255)
	clr.alpha = _alpha
endfunction clr



// Test whether two colors are the equal.
function clr_Compare(_clr1 as t_Color, _clr2 as t_Color)
	if not _clr1.red = _clr2.red then exitfunction 0
	if not _clr1.green = _clr2.green then exitfunction 0
	if not _clr1.blue = _clr2.blue then exitfunction 0
	if not _clr1.alpha = _clr2.alpha then exitfunction 0
endfunction 1

// Test whether a clr and a sprites color are equal.
function clr_CompareSprite(_clr as t_Color, _sprID)
	if not _clr.red = GetSpriteColorRed( _sprID ) then exitfunction 0
	if not _clr.green = GetSpriteColorGreen( _sprID ) then exitfunction 0
	if not _clr.blue = GetSpriteColorBlue( _sprID ) then exitfunction 0
	if not _clr.alpha = GetSpriteColorAlpha( _sprID ) then exitfunction 0
endfunction 1



// Set the color of a sprite to the parameter color.
function clr_SetSpriteColor(_sprID as integer, _clr as t_Color)
	SetSpriteColor(_sprID, _clr.red, _clr.green, _clr.blue, _clr.alpha)
endfunction

// Set the color of a text to the parameter color.
function clr_SetTextColor(_txtID as integer, _clr as t_Color)
	SetTextColor(_txtID, _clr.red, _clr.green, _clr.blue, _clr.alpha)
endfunction

// Set the color of a text to the parameter color.
function clr_SetTextCharColor(_txtID as integer, _CharIndex, _clr as t_Color)
	SetTextCharColor(_txtID, _CharIndex, _clr.red, _clr.green, _clr.blue, _clr.alpha)
endfunction



// Convert a color to readable string format.
function clr_Str(_clr as t_Color)
	_s as string
	_s = "[" + str(_clr.red) + ", " + str(_clr.green) + ", " + str(_clr.blue) + ", " + str(_clr.alpha) + "]"
endfunction _s


// Swap two colors.
function clr_swap(_clr1 ref as t_Color, _clr2 ref as t_Color)
	local _temp as t_Color
	_temp = _clr1
	_clr1 = _clr2
	_clr2 = _temp
endfunction






// Convert HSV to RGB clr.
function clr_hsv2rgb(_h#, _s#, _v#, _a)
	_clr as t_Color
	_c# = _s# * _v#
	_x# = _c# * (1 - abs(fmod(_h# / 60.0, 2) - 1))
	_m# = _v# - _c#
	_Rs# = 0.0 : _Gs# = 0.0 : _Bs# = 0.0
	
	if clr_inrange_f(_h#, 0.0, 60.0)
		_Rs# = _c#
		_Gs# = _x#
		_Bs# = 0.0
		
	elseif clr_inrange_f(_h#, 60.0, 120.0)
		_Rs# = _x#
		_Gs# = _c#
		_Bs# = 0.0
		
	elseif clr_inrange_f(_h#, 120.0, 180.0)
		_Rs# = 0.0
		_Gs# = _c#
		_Bs# = _x#
		
	elseif clr_inrange_f(_h#, 180.0, 240.0)
		_Rs# = 0.0
		_Gs# = _x#
		_Bs# = _c#
		
	elseif clr_inrange_f(_h#, 240.0, 300.0)
		_Rs# = _x#
		_Gs# = 0.0
		_Bs# = _c#
		
	elseif clr_inrange_f(_h#, 300.0, 360.0)
		_Rs# = _c#
		_Gs# = 0.0
		_Bs# = _x#
		
	else
		_Rs# = 0.0
		_Gs# = 0.0
		_Bs# = 0.0
	endif
	
	_clr.red = (_Rs# + _m#) * 255.0
	_clr.green = (_Gs# + _m#) * 255.0
	_clr.blue = (_Bs# + _m#) * 255.0
	_clr.alpha = _a
endfunction _clr



// Convert a clr to a hue value.
function clr_Hue(_clr as t_Color)
	_min# = clr_min_f(clr_min_f(_clr.red, _clr.green), _clr.blue)
	_max# = clr_max_f(clr_max_f(_clr.red, _clr.green), _clr.blue)
	
	if _min# = _max# then exitfunction 0
	
	_hue# = 0.0
	
	if _max# = _clr.red
		_hue# = (_clr.green - _clr.blue) / (_max# - _min#)
	elseif _max# = _clr.green
		_hue# = 2.0 + (_clr.blue - _clr.red) / (_max# - _min#)
	else
		_hue# = 4.0 + (_clr.red - _clr.green) / (_max# - _min#)
	endif
	
	_hue# = _hue# * 60.0
	
	if _hue# < 0.0 then inc _hue#, 360.0
	
	_ret = round(_hue#)
endfunction _ret



function clr_min_f(_v1#, _v2#)
	if _v1# < _v2# then exitfunction _v1#
endfunction _v2#

function clr_max_f(_v1#, _v2#)
	if _v1# > _v2# then exitfunction _v1#
endfunction _v2#

function clr_inrange_f(_val#, _min#, _max#)
	if _val# < _min# then exitfunction 0
	if _val# > _max# then exitfunction 0
endfunction 1

function clr_inrange_i(_val, _min, _max)
	if _val < _min then exitfunction 0
	if _val > _max then exitfunction 0
endfunction 1















// Interpolate between nth colors based on a certain factor between 0 and 1.
function clr_MultiLerp(_clrArr as t_Color[], _factor#)
	_rc as t_Color
	if _factor# <= 0.0
		_rc = _clrArr[1]
		
	elseif _factor# >= 1.0
		_rc = _clrArr[_clrArr.length]
		
	else
		_grid# = _factor# * _clrArr.length
		_floor = floor(_grid#)
		_perc# = _grid# - _floor
		_index1 = _floor
		_index2 = _floor + 1
		
		clr_baseLerp(_rc, _clrArr[_index1], _clrArr[_index2], _perc#, 1)
	endif
endfunction _rc

// Interpolate between nth colors based on a certain factor between 0 and 1.
function clr_MultiLerpRGB(_clrArr as t_Color[], _factor#, _alpha)
	_rc as t_Color
	if _factor# <= 0.0
		_rc = _clrArr[1]
		
	elseif _factor# >= 1.0
		_rc = _clrArr[_clrArr.length]
		
	else
		_grid# = _factor# * _clrArr.length
		_floor = floor(_grid#)
		_perc# = _grid# - _floor
		_index1 = _floor
		_index2 = _floor + 1
		
		clr_baseLerp(_rc, _clrArr[_index1], _clrArr[_index2], _perc#, 0)
	endif
	_rc.alpha = _alpha
endfunction _rc

// Basic interpolation function.
function clr_baseLerp(_clr ref as t_Color, _clr_0 as t_Color, _clr_1 as t_Color, _factor#, _Alpha)
	_clr.red = ((1.0 - _factor#) * _clr_0.red) + (_factor# * _clr_1.red)
	_clr.green = ((1.0 - _factor#) * _clr_0.green) + (_factor# * _clr_1.green)
	_clr.blue = ((1.0 - _factor#) * _clr_0.blue) + (_factor# * _clr_1.blue)
	if _Alpha then _clr.alpha = ((1.0 - _factor#) * _clr_0.alpha) + (_factor# * _clr_1.alpha)
endfunction







// Replaces clr1 with clr2 in the image and returns a new image id.
function clr_ReplaceImageColor(_imgID, _clr1 as t_Color, _clr2 as t_Color)
	_mem = CreateMemblockFromImage(_imgID)
	
	_width = GetMemblockInt(_mem, 0)
	_height = GetMemblockInt(_mem, 4)
	
	_currByte = 8
	for i = 1 to _width
		for j = 1 to _height
			inc _currByte, 4
			
			if not GetMemblockByte(_mem, _currByte) = _clr1.red then continue
			if not GetMemblockByte(_mem, _currByte + 1) = _clr1.green then continue
			if not GetMemblockByte(_mem, _currByte + 2) = _clr1.blue then continue
			if not GetMemblockByte(_mem, _currByte + 3) = _clr1.alpha then continue
			
			SetMemblockByte( _mem, _currByte, _clr2.red )		// R
			SetMemblockByte( _mem, _currByte + 1, _clr2.green )	// G
			SetMemblockByte( _mem, _currByte + 2, _clr2.blue )	// B
			SetMemblockByte( _mem, _currByte + 3, _clr2.alpha )	// A
		next j
	next i
	
	_ret_imgID = CreateImageFromMemblock(_mem)
	
	DeleteMemblock(_mem)
endfunction _ret_imgID



// Replaces clr1 with clr2 in the image and returns a new image id.
// Replaces the color within a range instead of the exactly matching colors.
function clr_ReplaceColorInRange(_imgID, _clr1 as t_Color, _clr2 as t_Color, _range#)
	_mem = CreateMemblockFromImage(_imgID)
	
	_width = GetMemblockInt(_mem, 0)
	_height = GetMemblockInt(_mem, 4)

	_step = (_range# * 360.0) * 0.5
	_targHue = clr_Hue(_clr1)
	_targMin = _targHue - _step
	_targMax = _targHue + _step
	
	_currByte = 8
	for i = 1 to _width
		for j = 1 to _height
			inc _currByte, 4
			
			_currHue = clr_Hue(clr(GetMemblockByte(_mem, _currByte), GetMemblockByte(_mem, _currByte + 1), GetMemblockByte(_mem, _currByte + 2), 0))
			
			if clr_inrange_i(_currHue, _targMin, _targMax)
				SetMemblockByte( _mem, _currByte, _clr2.red )		// R
				SetMemblockByte( _mem, _currByte + 1, _clr2.green )	// G
				SetMemblockByte( _mem, _currByte + 2, _clr2.blue )	// B
				SetMemblockByte( _mem, _currByte + 3, _clr2.alpha )	// A
			endif
		next j
	next i
	
	_ret_imgID = CreateImageFromMemblock(_mem)
	
	DeleteMemblock(_mem)
endfunction _ret_imgID




// Replaces copyTo image with copyFrom image specifically at the given color.
// _copyTo_imgID   --> The image to write to.
// _copyFrom_imgID --> The image to copy from.
// _clr --> The color to find and change.
// _range# --> 0.0 to 1.0. Allows similar colors.
function clr_ReplaceColorInRangeImage(_copyTo_imgID, _copyFrom_imgID, _clr as t_Color, _range#)
	_memTo = CreateMemblockFromImage(_copyTo_imgID)
	_memFrom = CreateMemblockFromImage(_copyFrom_imgID)
	
	if not GetMemblockInt(_memTo, 0) = GetMemblockInt(_memFrom, 0) or not GetMemblockInt(_memTo, 4) = GetMemblockInt(_memFrom, 4)
		DeleteMemblock(_memTo)
		DeleteMemblock(_memFrom)
		Message("Error: Images must have identical dimensions." + chr(10) + chr(10) + "ReplaceColorInRangeImage()")
		exitfunction -1
	endif
	
	_width = GetMemblockInt(_memTo, 0)
	_height = GetMemblockInt(_memTo, 4)

	_step = (_range# * 360.0) * 0.5
	_targHue = clr_Hue(_clr)
	_targMin = _targHue - _step
	_targMax = _targHue + _step
	
	_currByte = 8
	for i = 1 to _width
		for j = 1 to _height
			inc _currByte, 4
			
			_currHue = clr_Hue(clr(GetMemblockByte(_memTo, _currByte), GetMemblockByte(_memTo, _currByte + 1), GetMemblockByte(_memTo, _currByte + 2), 0))
			
			if clr_inrange_i(_currHue, _targMin, _targMax)
				SetMemblockByte( _memTo, _currByte, GetMemblockByte(_memFrom, _currByte) )			// R
				SetMemblockByte( _memTo, _currByte + 1, GetMemblockByte(_memFrom, _currByte + 1) )	// G
				SetMemblockByte( _memTo, _currByte + 2, GetMemblockByte(_memFrom, _currByte + 2) )	// B
				SetMemblockByte( _memTo, _currByte + 3, GetMemblockByte(_memFrom, _currByte + 3) )	// A
			endif
		next j
	next i
	
	_ret_imgID = CreateImageFromMemblock(_memTo)
	
	DeleteMemblock(_memTo)
	DeleteMemblock(_memFrom)
endfunction _ret_imgID