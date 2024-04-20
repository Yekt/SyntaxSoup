# resolution scaling: https://www.youtube.com/watch?v=blPqie3Z_F0

extends Node2D


var GLOBALS


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	pass
	
	
func spawn_asteroid():
	%SpawnPoint.progress_ratio = randf()
	var rng = randf()
	var asteroid
	if (rng <= 0.5):
		asteroid = Asteroid.create_asteroid(0, Vector2.RIGHT + Vector2(0, randf_range(-0.1, 0.1)))
	elif (rng <= 0.8333):
		asteroid = Asteroid.create_asteroid(1, Vector2.RIGHT + Vector2(0, randf_range(-0.1, 0.1)))
	else:
		asteroid = Asteroid.create_asteroid(2, Vector2.RIGHT + Vector2(0, randf_range(-0.1, 0.1)))
	asteroid.global_position = %SpawnPoint.global_position
	add_child(asteroid)
	
