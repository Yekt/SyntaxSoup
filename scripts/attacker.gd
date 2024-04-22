extends Ship

const PROJECTILE = preload("res://entities/projectile.tscn")

var damage = 1
var blaster = true
var globals

func _ready():
	globals = get_node("/root/Globals")
	update_values()

func _physics_process(delta):
	update_values()
	super._physics_process(delta)
	$ShipSprite.frame = 3 - floor((float(health) / float(max_health + 1)) * 4)

	$HealthHud.frame = floor((float(health) / float(max_health + 1)) * 5)
	$ShieldHud.frame = floor((float($Shield.energy) / float($Shield.max_shield + 1)) * 5)

	if get_input_direction().length() > 0.1:
		$EngineAnimation.play("running")
	else:
		$EngineAnimation.play("idle")

	if Input.is_action_pressed("attacker_shield_burst") and $Shield.burst_timer > 5:
		$Shield.burst()

func get_input_direction():
	return Input.get_vector("attacker_left", "attacker_right", "attacker_up", "attacker_down")

func get_dodge_input():
	return Input.is_action_pressed("attacker_dodge")

func shoot():
	var projectile = PROJECTILE.instantiate()
	if blaster:
		projectile.global_position = %Blaster1.global_position
		projectile.DAMAGE = damage
		%Blaster1.add_child(projectile)
	else:
		projectile.global_position = %Blaster2.global_position
		projectile.DAMAGE = damage
		%Blaster2.add_child(projectile)
	blaster = !blaster
	
func update_values():
	%AttackTimer.wait_time = 0.25 / globals.BLASTER_SPEED_LEVEL
	damage = globals.BLASTER_DAMAGE_LEVEL
	$Shield.max_shield = 100 * globals.SHIELD_CAPACITY_LEVEL
	$Shield.shield_regen = 20 * globals.SHIELD_RECHARGE_LEVEL
	$Shield.burst_strength = 10 + globals.BURST_LEVEL * 2
	
