extends Control


const SPEED = 0.1


func _ready():
	%AttackerPosition.progress_ratio = 0.5
	%SupporterPosition.progress_ratio = 0.525
	%StartButton.grab_focus()


func _process(delta):
	var progress = fmod(-SPEED * delta, 1.0)
	%AttackerPosition.progress_ratio += progress
	%Attacker.global_position = %AttackerPosition.global_position
	%SupporterPosition.progress_ratio += progress
	%Supporter.global_position = %SupporterPosition.global_position


func start_game():
	get_tree().change_scene_to_file("res://scenes/screens/game.tscn")
	

func show_controls():
	print("This does nothing for now!")
	

func exit_game():
	get_tree().quit()
