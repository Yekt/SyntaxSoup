extends CharacterBody2D


var MOVEMENT_SPEED = 500
var HIT_POINTS = 100
var HP_REGEN_PER_S = 1
var SHIELD = 100
var SHIELD_REGEN_PER_S = 10


func _physics_process(delta):
	var direction = Input.get_vector("supporter_left", "supporter_right", "supporter_up", "supporter_down")
	velocity = direction * MOVEMENT_SPEED
	move_and_slide()
