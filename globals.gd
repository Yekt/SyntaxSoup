extends Node


var SPEED_SCALE = 1.0
var SCORE = 0

var BURST_LEVEL = 1
var BLASTER_DAMAGE_LEVEL = 1
var BLASTER_SPEED_LEVEL = 1
var ENERGY_CONVERSION = 1
var SHIELD_CAPACITY_LEVEL = 1
var SHIELD_RECHARGE_LEVEL = 1
var MAGNET_LEVEL = 4


func add_score(delta: int):
	SCORE += delta
	print(SCORE)


func reset():
	SCORE = 0
	SPEED_SCALE = 1.0
