extends BaseParticle
class_name Glass

func _init():
	self.mat_name = 'Glass'
	self.sprite_path = 'res://Assets/glass.png'
	self.g_scale = 0
	self.m = 10
	self.i = 10
	self.damp = 10
	self.replace_damp = false
	self.friction = 0
	self.bounce = 0
	self.absorbent = false
	self.rough = false
	self.texture_alpha = 0.75
	return
