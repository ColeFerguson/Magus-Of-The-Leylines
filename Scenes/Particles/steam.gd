extends BaseParticle
class_name Steam
var steam_count = 0
func _init():
	self.mat_name = "Steam"
	sprite_path = 'res://Assets/steam.png'
	self.g_scale= -1
	self.m = 0.001
	self.i = 0
	self.friction = .5
	self.bounce = 0.6
	self.absorbent = false
	self.rough = false
	return

func on_ready():
	await get_tree().create_timer(10).timeout
	self.queue_free()
	return

func on_particle_collision(other):
	#self.on_particle_collision(other)
	if other.get_parent() is Steam:
		steam_count += 1
	else:
		steam_count = 0
	if steam_count > 100:
		other.get_parent().queue_free()
		self.replace_with(Water, null)
	return
