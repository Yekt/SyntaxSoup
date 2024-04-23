extends Area2D


var GLOBALS


const BURST_COST = 50
const BURST_DURATION = 0.5


var max_shield = 100
var energy = max_shield
var cooldown = 2
var cooldown_timer = 1000
var is_bursting = false
var burst_timer = 1000
var burst_strength = 10


func _ready():
	GLOBALS = get_node("/root/Globals")


func _process(delta):
	burst_timer += delta

	if burst_timer >= BURST_DURATION:
		is_bursting = false
		$CollisionShape.scale = Vector2(1, 1)
	elif is_bursting:
		var scale = burst_timer * 4.0 * GLOBALS.BURST_LEVEL
		$BurstSprite.material.set_shader_parameter("scale", scale + 0.5)
		$CollisionShape.scale = Vector2(1, 1) * (scale + 1.0)

	for other in get_overlapping_areas():
		if is_bursting:
			other.destroy_and_spawn()
		elif energy > 0:
			energy -= other.DAMAGE
			other.destroy()
		if energy <= 0:
			cooldown_timer = 0

	$ShieldSprite.visible = energy > 0 and not is_bursting
	$BurstSprite.visible = is_bursting

	if energy <= 0:
		cooldown_timer += delta

	if cooldown_timer > cooldown:
		energy = clamp(energy, 0, max_shield)


func burst():
	if energy < BURST_COST:
		return
	energy -= BURST_COST
	if energy <= 0:
		cooldown_timer = 0
	is_bursting = true
	burst_timer = 0
	$AudioStreamPlayer2D.play()
