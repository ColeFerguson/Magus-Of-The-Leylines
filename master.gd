extends Node2D
#The material to place
var cur_mat = Sand
#Toggle set by if the mouse is in placing area
var can_place = false
#List of available materials. Changed by level
var mat_list = [Sand, RockWall, SoftWood, Smoke, Fire, Ash, Glass, HardWood, Dirt, Leaves, Water, Ice, Steam]
#Pointer to the current level. Is null if not in a level
var cur_lvl = null
#Bool for preventing input while a level is going
var lvl_started = false
#Counter for particles placed
var particles_placed = 0
#Bool to help know when to show warnings
var in_select = false

func _ready():
	if Global.going_to_sandbox == false and Global.is_first_launch == false:
		$victory_screen/nextlevel.connect('pressed', to_next_level)
		$victory_screen/levelselect.connect('pressed', start_level_select)
		start_level_select()
	elif Global.going_to_sandbox == false and Global.is_first_launch == true:
		$victory_screen/nextlevel.connect('pressed', to_next_level)
		$victory_screen/levelselect.connect('pressed', start_level_select)
		load_level(1)
		Global.is_first_launch = false
	else:
		var b = load('res://Scenes/border.tscn').instantiate()
		add_child(b)
		move_child(b,0)
		update_mat_list()
		hide_ui()
		$Camera2D/UI/MatList.show()
		can_place = true
	return

#Will show the level select and update it's values
func start_level_select():
	if cur_lvl != null:
		cur_lvl.queue_free()
		cur_lvl = null
	in_select = true
	hide_ui()
	$victory_screen.hide()
	$level_select.on_ready()
	$level_select.show()
	return

func on_level_selected(num):
	
	$level_select.hide()
	load_level(num)
	in_select = false
	return

#Will adjust the ui to have possible materials
func update_mat_list():
	$Camera2D/UI/MatList.clear()
	var idx = 0
	for i in mat_list:
		var temp = i.new()
		$Camera2D/UI/MatList.add_item(temp.mat_name)
		$Camera2D/UI/MatList.set_item_icon(idx, load(temp.sprite_path))
		$Camera2D/UI/MatList.set_item_metadata(idx, i)
		temp.queue_free()
		idx += 1
	return

#Places the currently selected particle if the can_place check is true
func _physics_process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if can_place == true:
			var new_p = cur_mat.new()
			$Particles.add_child(new_p)
			new_p.position = get_global_mouse_position()
			particles_placed += 1
		elif self.in_placeable_area == false:
			if in_select == false and mouse_in_ui == false and lvl_started == false:
				flash_warning($Camera2D/Warnings/PlaceWarning)
		else:
			if in_select == false and mouse_in_ui == false and lvl_started == false:
				flash_warning($Camera2D/Warnings/ManaWarning)
	if $Camera2D/UI/ManaBar.visible:
		$Camera2D/UI/ManaBar.value = particles_placed
		if $Camera2D/UI/ManaBar.value >= $Camera2D/UI/ManaBar.max_value:
			can_place = false
	return

#Will show a node, wait, then tween it out and reset
func flash_warning(node):
	node.show()
	await get_tree().create_timer(2).timeout
	var t = get_tree().create_tween()
	t.tween_property(node, 'modulate', Color(1,1,1,0),2)
	t.connect('finished', reset_warning_alpha)
	return

func reset_warning_alpha():
	for i in $Camera2D/Warnings.get_children():
		i.hide()
		i.modulate = Color(1,1,1,1)
	return

#General check for stray particles/nodes
func _process(_delta):
	Node2D.print_orphan_nodes()
	return

func _on_mat_list_item_selected(index):
	cur_mat = $Camera2D/UI/MatList.get_item_metadata(index)
	pass

#Loads level based on num
func load_level(num):
	for i in $Camera2D/Warnings.get_children():
		i.hide()
	if cur_lvl != null:
		cur_lvl.queue_free()
	clear_particles()
	var lvl = load(str('res://Scenes/Levels/level_', num, '.tscn')).instantiate()
	add_child(lvl)
	
	lvl.connect('level_won', on_level_won)
	cur_lvl = lvl
	self.mat_list = lvl.mats
	update_mat_list()
	self.move_child(lvl,0)
	lvl.on_load()
	for i in lvl.pas:
		i.connect('mouse_entered', mouse_entered_area)
		i.connect('mouse_exited', mouse_exited_area)
	$Camera2D/UI/ManaBar.max_value = lvl.mana_cap
	show_ui()
	lvl_started = false
	if lvl.need_start == false:
		$Camera2D/UI/Start.hide()
	return

var in_placeable_area = false
#Functions to connect to the placeable area in each level
func mouse_entered_area():
	if lvl_started == false:
		self.can_place = true
		self.in_placeable_area = true
	return

func mouse_exited_area():
	self.can_place = false
	self.in_placeable_area = false
	return

func _on_start_pressed():
	if cur_lvl == null:
		return
	lvl_started = true
	can_place = false
	cur_lvl.on_start()
	pass

func clear_particles():
	for i in $Particles.get_children():
		i.queue_free()
	particles_placed = 0
	return

func _on_reset_pressed():
	lvl_started = false
	var lvl_num = null
	if cur_lvl != null:
		lvl_num = cur_lvl.level_num
		cur_lvl.queue_free()
	clear_particles()
	load_level(lvl_num)
	pass

#Some helpers for hiding/showing ui
func hide_ui():
	for i in $Camera2D/UI.get_children():
		i.hide()
	return

func show_ui():
	for i in $Camera2D/UI.get_children():
		i.show()
	return

func to_next_level():
	if cur_lvl != null:
		var nxt = cur_lvl.level_num + 1
		cur_lvl.queue_free()
		if Global.levels.keys().has(nxt):
			$victory_screen.hide()
			load_level(nxt)
		else:
			get_tree().change_scene_to_file("res://menu.tscn")
	return

func on_level_won():
	hide_ui()
	var score = $Camera2D/UI/ManaBar.max_value - $Camera2D/UI/ManaBar.value
	if cur_lvl != null:
		var nxt = cur_lvl.level_num+1
		Global.levels[cur_lvl.level_num][1] = true
		if Global.levels.keys().has(nxt):
			Global.levels[nxt][0] = true
		if Global.levels[cur_lvl.level_num][2] < score:
			Global.levels[cur_lvl.level_num][2] = score
	$victory_screen/score.text = str('[center]Score: ', score)
	for i in $Camera2D/Warnings.get_children():
		i.hide()
	$victory_screen.show()
	return

#This is kinda dumb but the warnings pop up whenever you click a button so this will keep track of
#when the mouse is in a button to disable the warnings
var mouse_in_ui = false
func in_ui():
	mouse_in_ui = true
	return
func out_ui():
	mouse_in_ui = false
	return


func _on_menu_pressed():
	get_tree().change_scene_to_file('res://menu.tscn')
	pass # Replace with function body.
