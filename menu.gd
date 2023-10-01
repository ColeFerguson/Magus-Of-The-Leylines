extends Control

func _ready():
	$bg.play("default")
	$AnimationPlayer2.play('peek')
	return

func _on_button_pressed():
	Global.going_to_sandbox = false
	$ParticleTimer.stop()
	clear_particles()
	if Global.is_first_launch:
		$AnimationPlayer.play('fade_out')
	else:
		$AnimationPlayer.play("fade_away_simple")
		#get_tree().change_scene_to_file('res://master.tscn')
	pass


func _on_sandbox_pressed():
	Global.going_to_sandbox = true
	get_tree().change_scene_to_file('res://master.tscn')
	pass


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file('res://master.tscn')
	pass

func clear_particles():
	for i in $Particles.get_children():
			i.queue_free()
	counter = 0
	return

var prt_lst = [Sand, SoftWood, Ash, Water]
var counter = 0
func _on_particle_timer_timeout():
	prt_lst.shuffle()
	var p = prt_lst[0].new()

	$Particles.add_child(p)
	p.position.x += randi_range(-50,50)
	counter += 1
	if counter >= 200:
		clear_particles()
	pass
