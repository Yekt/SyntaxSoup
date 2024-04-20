# resolution scaling: https://www.youtube.com/watch?v=blPqie3Z_F0

extends Node2D


var GLOBALS
var ASTEROID_L = preload("res://scenes/entities/asteroid_large.tscn")
var ASTEROID_M = preload("res://scenes/entities/asteroid_medium.tscn")
var ASTEROID_S = preload("res://scenes/entities/asteroid_small.tscn")


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	pass
	
	
func spawn_asteroid():
	%SpawnPoint.progress_ratio = randf()
	var rng = randf()
	var asteroid
	if (rng <= 0.5):
		asteroid = ASTEROID_S.instantiate()
	elif (rng <= 0.8333):
		asteroid = ASTEROID_M.instantiate()
	else:
		asteroid = ASTEROID_L.instantiate()
	asteroid.global_position = %SpawnPoint.global_position
	add_child(asteroid)
	
