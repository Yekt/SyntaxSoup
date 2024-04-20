extends RigidBody2D

var textures = [
	preload("res://scenes/textures/Minerals/Icon8.png"),
	preload("res://scenes/textures/Minerals/Icon14.png"),
	preload("res://scenes/textures/Minerals/Icon23.png"),
	preload("res://scenes/textures/Minerals/Icon31.png"),
]

var rot_speed = 0
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = textures[randi() % textures.size()]
	rot_speed = randf_range(0.5, 1.0)
	if randi() % 2 == 0:
		rot_speed = -rot_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	rotate(rot_speed * delta)
