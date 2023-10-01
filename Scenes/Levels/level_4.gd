extends Level

func _init():
	self.mats = [Fire, SoftWood, HardWood]
	self.level_num = 4
	self.mana_cap = 15
	self.need_start = false
	return

func _ready():
	on_load()
	return


func on_load():
	pas = [$placeable_area]
	for i in 100:
		var w = Water.new()
		$Water.add_child(w)
	$bg.play('default')
	#pas = [$placeable_area, $placeable_area2]

	return

func on_start():
	
	return


var signal_emitted = false
func _on_winarea_body_entered(body):
	if body == $Balloon:
		if signal_emitted == false:
			emit_signal('level_won')
			signal_emitted = true
	pass # Replace with function body.
