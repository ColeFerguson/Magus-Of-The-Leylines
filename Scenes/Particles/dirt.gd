extends BaseParticle
class_name Dirt

func _init():
	self.mat_name = 'Dirt'
	self.sprite_path ='res://Assets/dirt_lower.png'
	self.g_scale = 0
	self.m = 30
	self.i = 30
	self.damp = 10
	self.replace_damp = false
	self.friction = 1
	self.bounce = 0
	self.absorbent = true
	self.rough = true
	return
