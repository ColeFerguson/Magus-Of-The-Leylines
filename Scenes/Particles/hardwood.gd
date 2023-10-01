extends BaseParticle
class_name HardWood

func _init():
	self.mat_name = 'Hard Wood'
	self.sprite_path = 'res://Assets/bark.png'
	self.g_scale = 0
	self.m = 100
	self.i = 100
	self.damp = 50
	self.replace_damp = true
	self.friction = 1
	self.bounce = 0
	self.absorbent = true
	self.rough = true
	self.can_burn = true
	self.burn_odds = 5
	return

func on_burn():
	self.replace_with(Fire, Ash)
	return
