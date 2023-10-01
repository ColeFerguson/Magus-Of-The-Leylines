extends Level

func _init():
	self.mats = [Fire, SoftWood, HardWood]
	self.level_num = 3
	self.mana_cap = 200
	self.need_start = false
	return

func _ready():
	#on_load()
	return

var p_lookup = {'h':HardWood,'l':Leaves}
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
	$bg.play('default')
	#pas = [$placeable_area, $placeable_area2]

	return

func on_start():
	
	return
var signal_emitted = false
func _process(_delta):
	if signal_emitted == false:
		if $Particles.get_child_count() < 250:
			emit_signal('level_won')
			signal_emitted = true
	return
