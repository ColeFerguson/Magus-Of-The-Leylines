extends Node2D
class_name Level

#Materials that are available for this level
var mats = [Sand]
#Number of allowed particles for this level
var mana_cap = 100
#The level number
var level_num = 0
#Score for this level
var score = 0
#List of pointers to all placeable areas
var pas = []
#Some levels don't need a start button, this will toggle it off
var need_start = true
#Called by master scene when ready
func on_load():
	
	return

#Triggered by the player clicking the Start button
func on_start():
	
	return

#Any additional calls when re-loading scene
func on_reset():
	
	return

#Tells master scene that the level is over
signal level_won
