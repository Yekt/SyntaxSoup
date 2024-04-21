extends CharacterBody2D


var MOVEMENT_SPEED = 500
var HIT_POINTS = 100
var HP_REGEN_PER_S = 1
var SHIELD = 100
var SHIELD_REGEN_PER_S = 10
var GLOBALS
var IMMUNITY_DURATION = 0.5
var IMMUNITY_TIMER = 1000
var MAGNET_STRENGTH = 4


func hit(damage):
	if IMMUNITY_TIMER < IMMUNITY_DURATION:
		return

	HIT_POINTS -= damage
	IMMUNITY_TIMER = 0

	if HIT_POINTS <= 0:
		get_tree().change_scene_to_file("res://scenes/screens/game_over.tscn")


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	IMMUNITY_TIMER += delta
	if IMMUNITY_TIMER < IMMUNITY_DURATION:
		visible = int(IMMUNITY_TIMER * 15) % 2
	else:
		visible = true

	var direction = Input.get_vector("supporter_left", "supporter_right", "supporter_up", "supporter_down")
	velocity = direction * MOVEMENT_SPEED

	for other in $PickupArea.get_overlapping_areas():
		other.queue_free()
		other.set_collision_layer_value(2, false)
		GLOBALS.add_score(1)

	if Input.is_action_pressed("supporter_magnet"):
		for other in $MagnetArea.get_overlapping_areas():
			var speed = other.velocity.length()
			var dir = other.velocity.normalized()
			var to_resource = (position - other.position).normalized()
			dir = (dir + to_resource * MAGNET_STRENGTH * delta).normalized()
			other.velocity = dir * speed
			print(other.name)

	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
