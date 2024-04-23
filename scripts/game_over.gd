extends Control


var GLOBALS
const URL = "https://syntax-soup-default-rtdb.europe-west1.firebasedatabase.app/scores.json"


func _ready():
	%HighScoreRequest.request_completed.connect(_on_get_request_completed)
	%HighScoreRequest.request(URL + "/?orderBy=\"score\"&limitToLast=5")
	GLOBALS = get_node("/root/Globals")
	%Score.text = str(GLOBALS.SCORE)
	%RestartButton.grab_focus()


func restart_game():
	GLOBALS.reset()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func start_menu():
	GLOBALS.reset()
	get_tree().change_scene_to_file("res://scenes/start.tscn")


func get_player_name():
	if %NameInput.text:
		return %NameInput.text
	if OS.get_environment("USERNAME"):
		return OS.get_environment("USERNAME")
	if OS.get_environment("USER"):
		return OS.get_environment("USER")
	return "Player"
	

func publish_score():
	%RestartButton.grab_focus()
	%NameInput.visible = false
	%PublishScoreButton.visible = false
	%HighScoreRequest.request_completed.connect(_on_post_request_completed)
	var json = JSON.stringify({"name": get_player_name(), "score":GLOBALS.SCORE})
	var headers = ["Content-Type: application/json"]
	%HighScoreRequest.request(URL, headers, HTTPClient.METHOD_POST, json)


func _on_post_request_completed(result, response_code, headers, body):
	if response_code != 200:
		print("Post nicht erfolgreich" + str(response_code))
	else:
		print("Post erfolgreich")


func _on_get_request_completed(result, response_code, headers, body):
	%HighScoreRequest.request_completed.disconnect(_on_get_request_completed)
	if response_code != 200:
		return
	
	var json = JSON.parse_string(body.get_string_from_utf8())
	var score_list = []
	var name_list = []
	for key in json.keys():
		score_list.append([json[key]["name"], json[key]["score"]])
	
	score_list.sort_custom(sort_ascending)
	print(score_list)
	%Rank5.set_text(str(score_list[0][1]) + " - " + str(score_list[0][0]))
	%Rank4.set_text(str(score_list[1][1]) + " - " + str(score_list[1][0]))
	%Rank3.set_text(str(score_list[2][1]) + " - " + str(score_list[2][0]))
	%Rank2.set_text(str(score_list[3][1]) + " - " + str(score_list[3][0]))
	%Rank1.set_text(str(score_list[4][1]) + " - " + str(score_list[4][0]))
	if GLOBALS.SCORE > score_list[0][1]:
		%NameInput.visible = true
		%PublishScoreButton.visible = true


func sort_ascending(a, b):
	if a[1] < b[1]:
		return true
	return false
