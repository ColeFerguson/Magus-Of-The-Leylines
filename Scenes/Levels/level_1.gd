extends Level

func _init():
	self.mats = [Sand]
	self.level_num = 1
	
	return

func on_load():
	$bg.play("default")
	pas = [$placeable_area]
	for i in 100:
		var w = Water.new()
		#w.global_position = $Water.global_position
		$Water.add_child(w)
	return

func on_start():
	$ball.freeze = false
	return

func _on_win_body_entered(body):
	if body == $ball:
		#print("level won")
		emit_signal('level_won')
	pass
