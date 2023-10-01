extends Node2D
class_name BaseParticle

var mat_name = 'Base'
#Variable gravity modifier, set to zero for materials that don't fall
var g_scale = 1
#Mass in kg
var m = 1
#Inertia in kg*px^2
var i = 0
#A decrease in both linear and angular forces (0-100)
#Can be -1 for weird inverse damping
var damp = 0
#Toggle to force a damp override in interactions
var replace_damp = false
#Friction (0-1)
var friction = 1.0
#True will use the highest friction in collision, false will use lowest
var rough = true
#Bounciness (0-1)
var bounce = 0
#Whether to reduce bounciness on collision
var absorbent = true
#Sprite file path
var sprite_path = 'res://Assets/sand16.png'
#Toggle to prevent references too early
var body_initiated = false
#Bool that's set whenever fire is touched
var touching_fire = false
#Bool that's set whenever ice is touched
var touching_ice = false
#Toggle to enable swapping for fire
var can_burn = false
#Toggel to enable freezing
var can_freeze = false
#Burn odds
var burn_odds = 50
#Freeze odds
var freeze_odds = 10
#Optional alpha
var texture_alpha = 1
#Optional scale adjustment. Will adjust collision to match
var col_scale = 1

#Sets all the proper parameters to the settings once the rigid body is loaded in
func update_settings():
	$RB.gravity_scale = self.g_scale
	$RB.mass = self.m
	$RB.inertia = self.i
	$RB.linear_damp = self.damp
	$RB.angular_damp = self.damp
	if self.replace_damp == true:
		$RB.linear_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
		$RB.angular_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
	$RB.physics_material_override.friction = self.friction
	$RB.physics_material_override.rough = self.rough
	$RB.physics_material_override.bounce = self.bounce
	$RB.physics_material_override.absorbent = self.absorbent
	$RB/Sprite.texture = load(self.sprite_path)
	$RB/Sprite.modulate.a = self.texture_alpha
	$RB/CollisionShape2D.scale = Vector2(self.col_scale, self.col_scale)
	$RB/Sprite.scale = Vector2(self.col_scale, self.col_scale)
	$RB/Light.scale = Vector2($RB/Light.scale.x * self.col_scale, $RB/Light.scale.y * self.col_scale)
	return

func _ready():
	var rb = load('res://Scenes/rb.tscn').instantiate()
	self.add_child(rb)
	rb.connect('body_entered', on_particle_collision)
	rb.connect('body_exited', on_body_left)
	self.body_initiated = true
	self.update_settings()
	self.on_ready()
	return

#Have to do this cause Godot's weird about inheriting default functions
func on_ready():
	
	return
	
func on_particle_collision(other):
	var p = other.get_parent()
	if p is Fire:
		touching_fire = true
	elif p is Water:
		if self is Fire:
			self.queue_free()
	elif p is Ice:
		touching_ice = true
	return

func on_body_left(_body):
	var fire_found = false
	var ice_found = false
	for p in self.get_node("RB").get_colliding_bodies():
		if p.get_parent() is Fire:
			fire_found = true
		elif p.get_parent() is Ice:
			ice_found = true
	touching_fire = fire_found
	touching_ice = ice_found
	return

#Random check to decide when to burn
func _process(_delta):
	if touching_fire:
		if randf_range(0,100) < self.burn_odds and self.can_burn:
			self.on_burn()
	if touching_ice:
		if randf_range(0, 100) < self.freeze_odds and can_freeze:
			self.on_freeze()
	return

func on_freeze():
	
	return

func on_burn():
	
	return

#Utility to create a new particle, put it in this one's place, and delete self. The opt is for optional param (mainly for fire waste)
#Just pass null if not applicable
func replace_with(particle, opt):
	var f = particle.new()
	self.get_node("RB").collision_layer = 2
	if f is Fire:
		f.waste = opt
	get_tree().get_root().get_node("Master/Particles").add_child(f)
	f.global_position = self.get_node("RB").global_position
	self.queue_free()
	return
