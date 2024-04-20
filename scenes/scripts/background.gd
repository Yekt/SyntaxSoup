extends Sprite2D

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_parameter("speed", 0.15)
	material.set_shader_parameter("angle", 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	material.set_shader_parameter("time", time)
	self.global_position = get_viewport().size / 2
	self.global_scale = get_viewport().size
