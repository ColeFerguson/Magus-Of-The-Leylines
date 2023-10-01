extends BaseParticle
class_name RockWall

func _init():
	self.mat_name = 'Rock Wall'
	var n = randi_range(1,3)
	self.sprite_path = str('res://Assets/rock',n,'.png')
	self.g_scale = 0
	self.m = 100
	self.i = 100
	self.damp = 50
	self.replace_damp = true
	self.friction = 1
	self.bounce = 0
	self.absorbent = true
	self.rough = true
	return
