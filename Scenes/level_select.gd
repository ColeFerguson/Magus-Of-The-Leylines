extends Control
#This loads in levels from the level data in the Global script
#This should account for high scores, unlocked, and beaten levels
func _ready():
	on_ready()
	return

#Called whenever the master scene switches over to level select
func on_ready():
	for i in $grid.get_children():
		i.queue_free()
	for l in Global.levels:
		var lb = load('res://Scenes/Levels/level_button.tscn').instantiate()
		lb.level_num = l
		$grid.add_child(lb)
		lb.get_node("Title").text = str('[center]Level ', l)
		lb.get_node("Image").texture = load(str('res://Assets/', Global.levels[l][3],'.png'))
		lb.get_node("Score").text = str('High Score: ', Global.levels[l][2])
		if Global.levels[l][0] == false:
			lb.get_node("Button").disabled = true
		
		lb.get_node("Button").pressed.connect(on_level_selected.bind(l))
	return

#Tells the master scene which level to go to
signal level_selected(num)
func on_level_selected(num):
	emit_signal('level_selected', num)
	return

#Quick exit to menu button
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
	pass
