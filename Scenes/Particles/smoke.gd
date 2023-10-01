extends BaseParticle
class_name Smoke

func _init():
	self.mat_name = "Smoke"
	sprite_path = 'res://Assets/gas.png'
	self.g_scale= -1
	self.m = 0.001
	self.i = 0
	self.damp = 5
	self.friction = 1.0
	self.bounce = 0.3
	self.absorbent = true
	self.rough = false
	return

func on_ready():
	await get_tree().create_timer(20).timeout
	self.queue_free()
	return
