extends Ship

const PROJECTILE = preload("res://scenes/entities/projectile.tscn")

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

	if get_input_direction().length() > 0.1:
		$EngineAnimation.play("running")
	else:
		$EngineAnimation.play("idle")

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
