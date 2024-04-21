extends CharacterBody2D
class_name Ship

var movement_speed = 500
var max_health = 100
var health = max_health
var immunity_duration = 0.5
var immunity_timer = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	immunity_timer += delta
	if immunity_timer < immunity_duration:
		visible = int(immunity_timer * 15) % 2
	else:
		visible = true

	var direction = get_input_direction()
	velocity = direction * movement_speed
	move_and_slide()
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if direction.length() > 0.1:
		$EngineAnimation.play("running")
	else:
		$EngineAnimation.play("idle")

func get_input_direction():
	return Vector2()

func hit(damage):
	if immunity_timer < immunity_duration:
		return

	health -= damage
	immunity_timer = 0

	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/screens/game_over.tscn")
