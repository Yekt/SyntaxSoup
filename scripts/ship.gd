extends CharacterBody2D
class_name Ship

var movement_speed = 500
var max_health = 100
var health = max_health
var immunity_duration = 0.5
var immunity_timer = 1000
var dodge_duration = 0.3
var dodge_timer = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if immunity_timer < immunity_duration:
		visible = int(immunity_timer * 15) % 2
		immunity_timer += delta
	else:
		visible = true

	var direction = get_input_direction().normalized()

	dodge_timer += delta
	if is_dodgeing():
		rotation = (dodge_timer / dodge_duration) * 2 * PI - PI / 2
	elif get_dodge_input() and direction.length() > 0.1:
		if $Shield.energy >= 10 and dodge_timer >= 1.0:
			$Shield.energy -= 10
			velocity = direction * movement_speed * 3
			dodge_timer = 0
	else:
		velocity = direction * movement_speed
		rotation = - PI / 2

	move_and_slide()

	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func get_input_direction():
	return Vector2()

func get_dodge_input():
	return false

func hit(damage):
	if immunity_timer < immunity_duration:
		return
	elif dodge_timer < dodge_duration:
		return

	health -= damage
	immunity_timer = 0

	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func is_dodgeing():
	return dodge_timer < dodge_duration
