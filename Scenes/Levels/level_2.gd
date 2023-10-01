extends Level

func _init():
	self.mats = [Sand, RockWall, Dirt]
	self.level_num = 2
	self.mana_cap = 150
	self.need_start = false
	return

func _ready():
	
	return

func on_load():
	$bg.play('default')
	pas = [$placeable_area, $placeable_area2]
	for i in 100:
		var w = Water.new()
		#w.global_position = $Water.global_position
		$Water.add_child(w)
	return

func on_start():
	
	return

var win_con = 40
func _on_area_2d_body_entered(_body):
	if $Area2D.get_overlapping_bodies().size() >= win_con:
		emit_signal('level_won')
	pass
