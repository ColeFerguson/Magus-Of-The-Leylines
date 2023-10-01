extends BaseParticle
class_name Fire
var waste = null
func _init():
	self.mat_name = 'Fire'
	self.sprite_path = 'res://Assets/fire.png'
	self.g_scale = 1
	self.m = 0.01
	self.i = 0
	self.damp = 25
	self.friction = 0
	self.bounce = 0
	self.absorbent = false
	self.rough = false
	self.can_burn = false
	self.texture_alpha = .8
	return

func on_ready():
	if self.body_initiated:
		get_node("RB/Light").visible = true
	await get_tree().create_timer(20).timeout
	if waste != null:
		self.replace_with(waste, null)
	else:
		self.queue_free()
	return

func _process(_delta):
	if randf_range(0,100) < .6 and body_initiated:
		var p = Smoke.new()
		p.global_position = Vector2(self.get_node("RB").global_position.x, self.get_node("RB").global_position.y-1)
		get_tree().get_root().get_node("Master/Particles").add_child(p)
		
	return
