extends CharacterBody2D


var MOVEMENT_SPEED = 500
var HIT_POINTS = 100
var HP_REGEN_PER_S = 1
var SHIELD = 100
var SHIELD_REGEN_PER_S = 10

func hit(damage):
	HIT_POINTS = HIT_POINTS - damage

func _physics_process(delta):
	var direction = Input.get_vector("supporter_left", "supporter_right", "supporter_up", "supporter_down")
	velocity = direction * MOVEMENT_SPEED
	move_and_slide()
	for i in get_slide_collision_count():
		var other = get_slide_collision(i).get_collider()
		if other.name == "Resource":
			var r = other as RigidBody2D
			r.queue_free()
			r.set_collision_layer_value(2, false)
			print("resource collected")

	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
