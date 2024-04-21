extends Control


var GLOBALS


func _ready():
	GLOBALS = get_node("/root/Globals")
	%Score.text = str(GLOBALS.SCORE)
	%RestartButton.grab_focus()


func restart_game():
	GLOBALS.reset()
	get_tree().change_scene_to_file("res://scenes/screens/game.tscn")


func start_menu():
	GLOBALS.reset()
	get_tree().change_scene_to_file("res://scenes/screens/start.tscn")


func publish_score():
	print("This does nothing for now!")
	#var name = %NameInput.text
	# if name != %NameInput.placeholder_text:
		#TODO push to FireBase
