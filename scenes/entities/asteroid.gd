extends Area2D

class_name Asteroid

#@export var direction: Vector2 = Vector2(0,0)
@export var speed = 1
@export var health = 1
var velocity

@export var to_spawn: Array[PackedScene]

func spawn_children():
	for child in to_spawn:
		var entity = child.instantiate()
		entity.position = self.position
		get_parent().add_child(entity)
		#entity.velocity = Vector2(randi() % 100, randi() % 100) * speed

func hit(damage):
	health = health - damage

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(1,0) * 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + velocity * delta
	
	for object in self.get_overlapping_bodies():
		object.hit(1)
		health = -1
	
	if health < 0:
		spawn_children()
		self.queue_free()
