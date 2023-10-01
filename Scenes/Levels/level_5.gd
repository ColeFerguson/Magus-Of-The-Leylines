extends Level

func _init():
	self.mats = [Water, Fire, HardWood, Dirt, RockWall]
	self.level_num = 5
	self.mana_cap = 60
	self.need_start = false
	return

func _ready():
	#on_load()
	return

var p_lookup = {'h':HardWood,'l':Leaves, 'i':Ice}
func on_load():
	pas = [$placeable_area]
	for p in $Particles.get_children():
		var newp = p_lookup[p.name.substr(0,1)].new()
		$Particles.add_child(newp)
		newp.position = p.position
		p.queue_free()
	#for i in 50:
		#var s = SoftWood.new()
		#$Softwood.add_child(s)
	#$bg.play('default')
	#pas = [$placeable_area, $placeable_area2]

	return

func on_start():
	
	return
var signal_emitted = false
func check_victory():
	if signal_emitted:
		return
	var c1 = false
	var c2 = false
	for i in $check1.get_overlapping_bodies():
		if i.get_parent() is Ice:
			c1 = true
	for k in $check2.get_overlapping_bodies():
		if k.get_parent() is Ice:
			c2 = true
	if c1 and c2:
		emit_signal('level_won')
		signal_emitted = true
	return

func _process(_delta):
	check_victory()
	return
