extends Node2D


var GLOBALS


const BASE_SPAWN_RATE = 1.5


func _ready():
	%Upgrades.visible = false
	GLOBALS = get_node("/root/Globals")


func _process(delta):
	%SpawnTimer.wait_time = BASE_SPAWN_RATE * pow(2.0, -4.0 * (float(GLOBALS.SCORE) / GLOBALS.SCORE_DOUBLED_SPEED))
	
	
func spawn_asteroid():
	%SpawnPoint.progress_ratio = randf()
	var rng = randf()
	var asteroid
	if (rng <= 0.5):
		asteroid = Asteroid.create_asteroid(0, Vector2.RIGHT + Vector2(0, randf_range(-0.1, 0.1)), GLOBALS)
	elif (rng <= 0.8333):
		asteroid = Asteroid.create_asteroid(1, Vector2.RIGHT + Vector2(0, randf_range(-0.1, 0.1)), GLOBALS)
	else:
		asteroid = Asteroid.create_asteroid(2, Vector2.RIGHT + Vector2(0, randf_range(-0.1, 0.1)), GLOBALS)
	asteroid.global_position = %SpawnPoint.global_position
	add_child(asteroid)
	

func show_upgrades():
	if GLOBALS.LEVEL < GLOBALS.MAX_LEVELS:
		%Upgrades.display_upgrades()