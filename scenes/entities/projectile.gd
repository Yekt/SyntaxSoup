extends Area2D


var GLOBALS


var DAMAGE = 1
var SPEED = 1000
var DRAWN = false


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	var direction = Vector2.LEFT
	position += direction * SPEED * delta * GLOBALS.SPEED_SCALE
	

func on_screen_exited():
	queue_free()
