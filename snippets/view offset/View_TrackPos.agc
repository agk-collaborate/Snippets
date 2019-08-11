
// Smoothly track a position with the ViewOffset regardless of frame rate.
function View_TrackPos(_x#, _y#, _offsetX#, _offsetY#, _factor#)
	SetViewOffset(lerp(GetViewOffsetX(), _x# - _offsetX#, _factor# / ScreenFPS()), lerp(GetViewOffsetY(), _y# - _offsetY#, _factor# / ScreenFPS()))
endfunction