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
	for object in self.get_overlapping_areas():
		object.hit(DAMAGE)
		self.queue_free()

func _on_body_entered(body):
	print(body.name)

func on_screen_exited():
	queue_free()
