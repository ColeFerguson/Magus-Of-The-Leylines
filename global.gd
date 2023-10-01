extends Node
#This is a global script to keep track of things that may need to be loaded between scenes

#List of level details. Keeps track of (in order):
#	is_unlocked (true,false)
#	has_been_beaten (true,false)
#	high_score (int)
#	level image (file name, must be in the form res://Assets/[name].png)
#	level file path (it's assumed it will be in res://Scenes/Levels and will end in .tscn)
var levels = {
	1:[true,false,0, 'l1', 'level_1'],
	2:[false,false,0,'l1','level_2'],
	3:[false,false,0,'l1','level_3'],
	4:[false,false,0,'l1','level_4'],
	5:[false,false,0,'l1','level_5'],
	6:[false,false,0,'l1','level_6']
}

#This is kinda cursed and is totally not how singletons/autoload scripts are supposed to be used
#BUUUUUT I didn't think about having different scenes for the sandbox vs regular game
#so now this is going to be temporarily toggled so the master scene knows when to load
#the sandbox vs the regular game
var going_to_sandbox = false

#Normally this would be saved in some settings somewhere, but game jam game so it's per instance now
var is_first_launch = true

#Same with volume settings
var volume = 30
