extends CharacterBody2D


const PROJECTILE = preload("res://scenes/entities/projectile.tscn")


var MOVEMENT_SPEED = 500
var ATTACK_SPEED = 0.25
var MAX_HEALTH = 100
var HIT_POINTS = MAX_HEALTH
var HP_REGEN_PER_S = 1
var SHIELD = 100
var SHIELD_REGEN_PER_S = 10
var BLASTER1 = true
var IMMUNITY_DURATION = 0.5
var IMMUNITY_TIMER = 1000


func hit(damage):
	if IMMUNITY_TIMER < IMMUNITY_DURATION:
		return

	HIT_POINTS -= damage
	$ShipSprite.frame = 3 - floor((HIT_POINTS / MAX_HEALTH) * 4)
	IMMUNITY_TIMER = 0

	if HIT_POINTS <= 0:
		get_tree().change_scene_to_file("res://scenes/screens/game_over.tscn")


func _ready():
	%AttackTimer.wait_time = ATTACK_SPEED


func _physics_process(delta):
	IMMUNITY_TIMER += delta
	if IMMUNITY_TIMER < IMMUNITY_DURATION:
		visible = int(IMMUNITY_TIMER * 15) % 2
	else:
		visible = true

	var direction = Input.get_vector("attacker_left", "attacker_right", "attacker_up", "attacker_down")
	velocity = direction * MOVEMENT_SPEED
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
