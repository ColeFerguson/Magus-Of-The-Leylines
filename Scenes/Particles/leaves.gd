extends BaseParticle
class_name Leaves

func _init():
	self.mat_name = 'Leaves'
	self.sprite_path = 'res://Assets/leaves.png'
	self.g_scale = 0
	self.m = 1
	self.i = 1
	self.damp = 0
	self.replace_damp = false
	self.friction = 0
	self.bounce = 0
	self.absorbent = false
	self.rough = true
	self.can_burn = true
	self.burn_odds = 80
	return

func on_burn():
	if randi_range(0,5) < 3:
		self.replace_with(Fire, null)
	else:
		self.queue_free()
	return
