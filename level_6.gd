extends Level

func _init():
	self.mats = [Steam, Ice, Fire, Smoke, SoftWood, Dirt, RockWall]
	self.level_num = 6
	self.mana_cap = 350
	self.need_start = false
	return

func _ready():
	on_load()
	return

func on_load():
	pas = [$placeable_area]
	$bg.play('default')
	for i in 3:
		var p = Fire.new()
		$FirePit.add_child(p)
	return

func on_start():
	
	return

func _on_timer_timeout():
	for i in 3:
		var p = Fire.new()
		$FirePit.add_child(p)
	pass
var signal_emitted = false
func _process(_delta):
	if $FirePit.get_child_count() == 0 and signal_emitted == false:
		emit_signal("level_won")
		signal_emitted = true
	return
