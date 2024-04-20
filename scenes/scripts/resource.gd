extends RigidBody2D

var textures = [
	preload("res://scenes/textures/Minerals/Icon8.png"),
	preload("res://scenes/textures/Minerals/Icon14.png"),
	preload("res://scenes/textures/Minerals/Icon23.png"),
	preload("res://scenes/textures/Minerals/Icon31.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = textures[randi() % textures.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
