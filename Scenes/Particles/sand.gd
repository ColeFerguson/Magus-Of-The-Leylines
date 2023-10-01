extends BaseParticle
class_name Sand

func _init():
	self.mat_name = "Sand"
	sprite_path = 'res://Assets/sand16.png'
	self.g_scale= 1
	self.m = 0.1
	self.i = 0
	self.friction = 0.2
	self.bounce = .3
	self.absorbent = true
	self.rough = false
	self.burn_odds = .01
	self.can_burn = true
	return

func on_burn():
	self.replace_with(Glass, null)
	return
