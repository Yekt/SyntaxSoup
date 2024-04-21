extends Node


var SPEED_SCALE = 1.0
var SCORE = 0


func add_score(delta: int):
	SCORE += delta
	print(SCORE)


func reset():
	SCORE = 0
	SPEED_SCALE = 1.0
