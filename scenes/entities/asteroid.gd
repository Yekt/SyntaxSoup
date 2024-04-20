extends RigidBody2D

class_name Asteroid

#@export var direction: Vector2 = Vector2(0,0)
@export var speed = 1
@export var health = 1
var velocity

@export var to_spawn: Array[PackedScene]

func spawn_children():
	for child in to_spawn:
		var entity = child.instantiate()
		get_parent().add_child(entity)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(randi() % 100, randi() % 100) * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(velocity)
	if health < 0:
		spawn_children()
		self.queue_free()
