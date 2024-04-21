extends Control


var GLOBALS
var url = "https://syntax-soup-default-rtdb.europe-west1.firebasedatabase.app/scores.json"

func _ready():
	%HighScoreRequest.request_completed.connect(_on_get_request_completed)
	%HighScoreRequest.request(url + "/?orderBy=\"score\"&limitToLast=5")
	GLOBALS = get_node("/root/Globals")
	%Score.text = str(GLOBALS.SCORE)
	%RestartButton.grab_focus()


func restart_game():
	GLOBALS.reset()
	get_tree().change_scene_to_file("res://scenes/screens/game.tscn")


func start_menu():
	GLOBALS.reset()
	get_tree().change_scene_to_file("res://scenes/screens/start.tscn")

func get_player_name():
	if %NameInput.text:
		return %NameInput.text
	if OS.get_environment("USERNAME"):
		return OS.get_environment("USERNAME")
	if OS.get_environment("USER"):
		return OS.get_environment("USER")
	return "Player"
	

func publish_score():
	%HighScoreRequest.request_completed.connect(_on_post_request_completed)
	var json = JSON.stringify({"name": get_player_name(), "score":GLOBALS.SCORE})
	var headers = ["Content-Type: application/json"]
	%HighScoreRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_post_request_completed(result, response_code, headers, body):
	if response_code != 200:
		print("Post nicht erfolgreich" + str(response_code))
	else:
		print("Post erfolgreich")

func _on_get_request_completed(result, response_code, headers, body):
	if response_code != 200:
		return
	
	var json = JSON.parse_string(body.get_string_from_utf8())
	var score_list = []
	var name_list = []
	for key in json.keys():
		score_list.append([json[key]["name"], json[key]["score"]])
	
	score_list.sort_custom(sort_ascending)
	print(score_list)
	$VBoxContainer/ActionsContainer/krankerName/RichTextLabel.set_text(str(score_list[0][0]) + " - " + str(score_list[0][1]))
	$VBoxContainer/ActionsContainer/krankerName/RichTextLabel2.set_text(str(score_list[1][0]) + " - " + str(score_list[1][1]))
	$VBoxContainer/ActionsContainer/krankerName/RichTextLabel3.set_text(str(score_list[2][0]) + " - " + str(score_list[2][1]))
	$VBoxContainer/ActionsContainer/krankerName/RichTextLabel4.set_text(str(score_list[3][0]) + " - " + str(score_list[3][1]))
	$VBoxContainer/ActionsContainer/krankerName/RichTextLabel5.set_text(str(score_list[4][0]) + " - " + str(score_list[4][1]))

func sort_ascending(a, b):
	if a[1] < b[1]:
		return true
	return false
