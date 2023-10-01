extends BaseParticle
class_name Water

func _init():
	self.mat_name = 'Water'
	self.sprite_path = 'res://Assets/water.png'
	self.g_scale = 1
	self.m = .01
	self.i = 0
	self.damp = -.1
	self.replace_damp = true
	self.friction = 0
	self.bounce = 2
	self.absorbent = true
	self.rough = false
	self.can_burn = true
	self.burn_odds = 20
	self.can_freeze = true
	self.freeze_odds = 20
	return

func on_burn():
	self.replace_with(Steam, null)
	return
func on_freeze():
	self.replace_with(Ice, null)
	return
