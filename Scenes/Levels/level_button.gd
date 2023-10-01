extends Control
#There are better ways to do this, but time is running out and I know this will work lol
var level_num = 0

#Quick fix for dimming level image
func _process(_delta):
	if $Button.disabled == true:
		$Image.modulate = Color(0.4,0.4,0.4,0.4)
	else:
		$Image.modulate = Color(1,1,1,1)
	return
