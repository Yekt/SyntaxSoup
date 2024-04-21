extends Area2D

var max_shield = 100
var energy = max_shield
var shield_regen = 20
var cooldown = 2
var cooldown_timer = 1000
var is_bursting = false
var burst_timer = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	burst_timer += delta

	if burst_timer >= 1:
		is_bursting = false
		scale = Vector2(1, 1)
	elif is_bursting:
		get_child(2).material.set_shader_parameter("time", burst_timer)
		scale = Vector2(10, 10) * burst_timer

	get_child(2).visible = is_bursting

	for other in get_overlapping_areas():
		if energy > 0:
			energy -= other.DAMAGE
			other.destroy()
		elif is_bursting:
			other.destroy()
		if energy <= 0:
			cooldown_timer = 0

	get_child(1).visible = energy > 0 and not is_bursting

	if energy <= 0:
		cooldown_timer += delta

	if cooldown_timer > cooldown:
		energy = clamp(energy + shield_regen * delta, 0, max_shield)

func burst():
	if energy < 100:
		return

	energy -= 100
	if energy <= 0:
		cooldown_timer = 0
	
	is_bursting = true
	burst_timer = 0

