extends CharacterBody2D


var GLOBALS


var MOVEMENT_SPEED = 500
var HIT_POINTS = 100
var HP_REGEN_PER_S = 1
var SHIELD = 100
var SHIELD_REGEN_PER_S = 10

func hit(damage):
	HIT_POINTS = HIT_POINTS - damage

func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	var direction = Input.get_vector("supporter_left", "supporter_right", "supporter_up", "supporter_down")
	velocity = direction * MOVEMENT_SPEED * GLOBALS.SPEED_SCALE
	move_and_slide()
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
