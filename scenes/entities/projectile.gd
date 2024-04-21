extends Area2D


@export var DAMAGE = 1
@export var SPEED = 1000
@export var DRAWN = false


func _ready():
	$AnimatedSprite2D.play('default')

func _physics_process(delta):
	var direction = Vector2.LEFT

	position += direction * SPEED * delta
	for object in self.get_overlapping_areas():
		object.hit(DAMAGE)
		self.queue_free()

func on_screen_exited():
	queue_free()
