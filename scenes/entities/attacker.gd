extends CharacterBody2D


var GLOBALS
const PROJECTILE = preload("res://scenes/entities/projectile.tscn")


var MOVEMENT_SPEED = 500
var ATTACK_SPEED = 0.25
var HIT_POINTS = 100
var HP_REGEN_PER_S = 1
var SHIELD = 100
var SHIELD_REGEN_PER_S = 10
var BLASTER1 = true

func hit(damage):
	HIT_POINTS = HIT_POINTS - damage

func _ready():
	GLOBALS = get_node("/root/Globals")
	%AttackTimer.wait_time = ATTACK_SPEED

func _physics_process(delta):
	var direction = Input.get_vector("attacker_left", "attacker_right", "attacker_up", "attacker_down")
	velocity = direction * MOVEMENT_SPEED * GLOBALS.SPEED_SCALE
	move_and_slide()
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if direction.length() > 0.1:
		$EngineAnimation.play("running")
	else:
		$EngineAnimation.play("idle")

func shoot():
	var projectile = PROJECTILE.instantiate()
	if BLASTER1:
		projectile.global_position = %Blaster1.global_position
		%Blaster1.add_child(projectile)
	else:
		projectile.global_position = %Blaster2.global_position
		%Blaster2.add_child(projectile)
	BLASTER1 = !BLASTER1
