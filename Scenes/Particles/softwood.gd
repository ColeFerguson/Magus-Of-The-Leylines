extends BaseParticle
class_name SoftWood

func _init():
	self.mat_name = 'Soft Wood'
	self.sprite_path = 'res://Assets/wood2.png'
	self.g_scale = 3
	self.m = 50
	self.i = 50
	self.damp = 15
	self.replace_damp = true
	self.friction = 1
	self.bounce = 0
	self.absorbent = true
	self.rough = true
	self.can_burn = true
	self.burn_odds = 20
	return

func on_burn():
	self.replace_with(Fire, Ash)
	return
