extends BaseParticle
class_name Ash

func _init():
	self.mat_name = 'Ash'
	self.sprite_path = 'res://Assets/ash.png'
	self.g_scale = 1
	self.m = 0.1
	self.i = 0
	self.damp = 0
	self.friction = 1
	self.bounce = 0
	self.absorbent = false
	self.rough = true
	return

