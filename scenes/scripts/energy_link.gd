extends Sprite2D

var time = 0
var brightness = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	brightness = lerp(brightness, 1.0, delta)
	material.set_shader_parameter("time", time)
	material.set_shader_parameter("brightness", brightness)
	material.set_shader_parameter("begin", $"/root/Game/Attacker".position)
	material.set_shader_parameter("end", $"/root/Game/Supporter".position)
	self.global_position = get_viewport().size / 2
	self.global_scale = get_viewport().size
