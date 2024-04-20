extends Area2D


var DAMAGE = 1
var SPEED = 1000
var DRAWN = false


func _physics_process(delta):
	var direction = Vector2.LEFT

	position += direction * SPEED * delta
	for object in self.get_overlapping_areas():
		object.hit(DAMAGE)
		self.queue_free()

func on_screen_exited():
	queue_free()
