extends Area2D

var max_shield = 100
var energy = max_shield
var shield_regen = 3
var cooldown = 2
var cooldown_timer = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for other in get_overlapping_areas():
		if energy > 0:
			energy -= other.DAMAGE
			other.destroy()
		if energy <= 0:
			cooldown_timer = 0

	$ShieldSprite.visible = energy > 0

	if energy <= 0:
		cooldown_timer += delta

	if cooldown_timer > cooldown:
		energy = clamp(energy + shield_regen * delta, 0, max_shield)
