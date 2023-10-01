extends BaseParticle
class_name Ice

func _init():
	self.mat_name = 'Ice'
	self.sprite_path = 'res://Assets/ice2.png'
	self.g_scale = 0
	self.m = 40
	self.i = 40
	self.damp = 0
	self.replace_damp = true
	self.friction = 0
	self.bounce = 0
	self.absorbent = true
	self.rough = false
	self.can_burn = true
	self.burn_odds = 80
	self.texture_alpha = .8
	return

func on_burn():
	self.replace_with(Water, null)
	return
