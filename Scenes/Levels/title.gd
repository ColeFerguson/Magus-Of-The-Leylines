extends RichTextLabel

func _ready():
	
	return


func _on_timer_timeout():
	$AnimationPlayer.play('fade_away')
	pass
