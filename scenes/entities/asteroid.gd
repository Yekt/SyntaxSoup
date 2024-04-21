extends Area2D
class_name Asteroid


const LARGE = 2
const MEDIUM = 1
const SMALL = 0
const ASTEROID = preload("res://scenes/entities/asteroid.tscn")
const RESOURCE = preload("res://scenes/entities/resource.tscn")
var GLOBALS


var SIZE
var DIRECTION
var SPEED
var HEALTH
var CHILDREN_COUNT
var IS_DESTROYED = false
var ROTATION
var DAMAGE
var velocity


static func create_asteroid(size: int, direction: Vector2) -> Asteroid:
	direction = direction.normalized()
	var speed_randomizer = randf_range(0.8, 1.2)
	var asteroid = ASTEROID.instantiate()
	if (size <= SMALL):
		asteroid.scale = Vector2(0.2, 0.2)
		asteroid.SIZE = SMALL
		asteroid.SPEED = 600 * speed_randomizer
		asteroid.HEALTH = 2
		asteroid.CHILDREN_COUNT = 3
		asteroid.ROTATION = randf_range(2, 2)
		asteroid.DAMAGE = 10
	elif (size == MEDIUM):
		asteroid.scale = Vector2(0.4, 0.4)
		asteroid.SIZE = MEDIUM
		asteroid.SPEED = 450 * speed_randomizer
		asteroid.HEALTH = 3
		asteroid.CHILDREN_COUNT = 3
		asteroid.ROTATION = randf_range(-1, 1)
		asteroid.DAMAGE = 20
	else: 
		asteroid.scale = Vector2(0.6, 0.6)
		asteroid.SIZE = LARGE
		asteroid.SPEED = 300 * speed_randomizer
		asteroid.HEALTH = 5
		asteroid.CHILDREN_COUNT = 2
		asteroid.ROTATION = randf_range(-0.3, 0.3)
		asteroid.DAMAGE = 30
	asteroid.DIRECTION = direction
	return asteroid


func _ready():
	GLOBALS = get_node("/root/Globals")
	SPEED *= GLOBALS.SPEED_SCALE
	velocity = SPEED * DIRECTION


func _process(delta):
	position += velocity * delta
	rotate(ROTATION * delta)

	if IS_DESTROYED:
		if !$Sprite.is_playing():
			queue_free()
		return

	for b in get_overlapping_bodies():
		if b.is_dodgeing():
			continue

		b.hit(DAMAGE)
		self.destroy()
		break


func spawn_children():
	for i in CHILDREN_COUNT:
		if SIZE == SMALL:
			var child = RESOURCE.instantiate()
			child.position = position
			child.velocity = randf_range(0.8, 1.2) * (velocity + Vector2(0, randf_range(-100, 100)))
			get_parent().add_child(child)
		else:
			var y_delta = 0.4 + abs(ROTATION) * 0.25
			var child = Asteroid.create_asteroid(SIZE-1, Vector2.RIGHT + Vector2(0, randf_range(-y_delta, y_delta)))
			child.position = position
			get_parent().add_child(child)


func hit(damage):
	if IS_DESTROYED:
		return

	HEALTH -= damage
	if HEALTH <= 0:
		self.destroy()


func destroy():
	if IS_DESTROYED:
		return

	spawn_children()
	IS_DESTROYED = true
	set_collision_layer_value(4, false)
	set_collision_layer_value(6, false)
	$Sprite.play("default")
	$AudioStreamPlayer2D.play()


func on_screen_exited():
	queue_free()
