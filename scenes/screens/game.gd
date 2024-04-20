# resolution scaling: https://www.youtube.com/watch?v=blPqie3Z_F0

extends Node2D


var GLOBALS
#var ASTEROID = preload("res://scenes/entities/asteroid.tscn")


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	pass
	
	
func spawn_asteroid():
	%SpawnPoint.progress_ratio = randf()
	var rng = randf()
	var asteroid
	if (rng <= 0.5):
		asteroid = Asteroid.create_asteroid(0, Vector2.RIGHT)
	elif (rng <= 0.8333):
		asteroid = Asteroid.create_asteroid(1, Vector2.RIGHT)
	else:
		asteroid = Asteroid.create_asteroid(2, Vector2.RIGHT)
	asteroid.global_position = %SpawnPoint.global_position
	add_child(asteroid)
	
