extends Area2D


var DAMAGE = 1
var SPEED = 1000
var DRAWN = false


func _physics_process(delta):
	var direction = Vector2.RIGHT
	position += direction * SPEED * delta
	

func on_screen_exited():
	queue_free()
