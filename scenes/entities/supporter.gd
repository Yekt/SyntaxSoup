extends Ship

var globals
var magnet_strength = 4

func _ready():
	globals = get_node("/root/Globals")

func _physics_process(delta):
	super._physics_process(delta)

	for other in $PickupArea.get_overlapping_areas():
		other.queue_free()
		other.set_collision_layer_value(2, false)
		globals.add_score(1)

	if Input.is_action_pressed("supporter_magnet"):
		for other in $MagnetArea.get_overlapping_areas():
			var speed = other.velocity.length()
			var dir = other.velocity.normalized()
			var to_resource = (position - other.position).normalized()
			dir = (dir + to_resource * magnet_strength * delta).normalized()
			other.velocity = dir * speed
			print(other.name)

func get_input_direction():
	return Input.get_vector("supporter_left", "supporter_right", "supporter_up", "supporter_down")

func get_dodge_input():
	return Input.is_action_pressed("supporter_dodge")

func update_values():
	magnet_strength = globals.MAGNET_LEVEL
