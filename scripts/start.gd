extends Control


const SPEED = 0.1
var ROTATION


func _ready():
	%AttackerPosition.progress_ratio = 0.5
	%SupporterPosition.progress_ratio = 0.525
	ROTATION = randf_range(2, 2)
	%StartButton.grab_focus()


func _process(delta):
	var progress = fmod(-SPEED * delta, 1.0)
	%AttackerPosition.progress_ratio += progress
	%Attacker.global_position = %AttackerPosition.global_position
	%SupporterPosition.progress_ratio += progress
	%Supporter.global_position = %SupporterPosition.global_position
	%AsteroidS1.rotate(ROTATION * delta)
	%AsteroidS2.rotate(ROTATION * delta * -1)
	%AsteroidM.rotate(ROTATION * delta * -0.2)
	%AsteroidL.rotate(ROTATION * delta * 0.05)


func start_game():
	if %Controls.visible:
		toggle_controls()
		return
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func toggle_controls():
	%Controls.visible = !%Controls.visible


func exit_game():
	if %Controls.visible:
		toggle_controls()
		return
	get_tree().quit()
