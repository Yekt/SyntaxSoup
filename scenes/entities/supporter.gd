extends Ship


signal show_upgrades


var globals
var magnet_strength = 4

func _ready():
	globals = get_node("/root/Globals")
	update_values()

func _physics_process(delta):
	super._physics_process(delta)
	update_values()

	$HealthHud.frame = floor((float(health) / float(max_health + 1)) * 5)
	$ShieldHud.frame = floor((float($Shield.energy) / float($Shield.max_shield + 1)) * 5)

	for other in $PickupArea.get_overlapping_areas():
		other.queue_free()
		other.set_collision_layer_value(2, false)
		globals.add_score(1)
		$AudioStreamPlayer2D.play()
		$"/root/Game/EnergyLink".brightness = 2.0

		$"/root/Game/Attacker/Shield".energy += globals.ENERGY_CONVERSION
		$Shield.energy += globals.ENERGY_CONVERSION
		
	if globals.SCORE >= globals.LAST_UPGRADE + globals.SCORE_SHOW_UPGRADE:
		show_upgrades.emit()
		globals.LAST_UPGRADE += globals.SCORE_SHOW_UPGRADE

	if Input.is_action_pressed("supporter_magnet"):
		for other in $MagnetArea.get_overlapping_areas():
			var speed = other.velocity.length()
			var dir = other.velocity.normalized()
			var to_resource = (position - other.position).normalized()
			dir = (dir + to_resource * delta).normalized()
			other.velocity = dir * speed
			print(other.name)

func get_input_direction():
	return Input.get_vector("supporter_left", "supporter_right", "supporter_up", "supporter_down")

func get_dodge_input():
	return Input.is_action_pressed("supporter_dodge")

func update_values():
	$MagnetArea.scale = Vector2(1.0 + 0.5 * globals.MAGNET_LEVEL, 1.0 + 0.5 * globals.MAGNET_LEVEL)
	$Shield.max_shield = 100 * globals.SHIELD_CAPACITY_LEVEL
	$Shield.shield_regen = 20 * globals.SHIELD_RECHARGE_LEVEL
	$Shield.burst_strength = 10 + globals.BURST_LEVEL * 2
	
