extends Ship

const PROJECTILE = preload("res://scenes/entities/projectile.tscn")

var attack_spead = 0.25
var blaster = true

func _ready():
	%AttackTimer.wait_time = attack_spead

func _physics_process(delta):
	super._physics_process(delta)
	$ShipSprite.frame = 3 - floor((float(health) / float(max_health + 1)) * 4)

func get_input_direction():
	return Input.get_vector("attacker_left", "attacker_right", "attacker_up", "attacker_down")

func get_dodge_input():
	return Input.is_action_pressed("attacker_dodge")

func shoot():
	var projectile = PROJECTILE.instantiate()
	if blaster:
		projectile.global_position = %Blaster1.global_position
		%Blaster1.add_child(projectile)
	else:
		projectile.global_position = %Blaster2.global_position
		%Blaster2.add_child(projectile)
	blaster = !blaster
