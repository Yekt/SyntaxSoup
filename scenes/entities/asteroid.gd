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
		asteroid.ROTATION = randf_range(-0.1, 0.1)
	elif (size == MEDIUM):
		asteroid.scale = Vector2(0.4, 0.4)
		asteroid.SIZE = MEDIUM
		asteroid.SPEED = 450 * speed_randomizer
		asteroid.HEALTH = 3
		asteroid.CHILDREN_COUNT = 3
		asteroid.ROTATION = randf_range(-0.05, 0.05)
	else: 
		asteroid.scale = Vector2(0.6, 0.6)
		asteroid.SIZE = LARGE
		asteroid.SPEED = 300 * speed_randomizer
		asteroid.HEALTH = 5
		asteroid.CHILDREN_COUNT = 2
		asteroid.ROTATION = randf_range(-0.01, 0.01)
	asteroid.DIRECTION = direction
	return asteroid


func _ready():
	GLOBALS = get_node("/root/Globals")
	SPEED *= GLOBALS.SPEED_SCALE


func _process(delta):
	position = position + DIRECTION * SPEED * delta
	rotate(ROTATION)

	if IS_DESTROYED:
		if !$Sprite.is_playing():
			queue_free()
		return


func spawn_children():
	for i in CHILDREN_COUNT:
		if SIZE == SMALL:
			var child = RESOURCE.instantiate()
			child.position = position
			child.velocity = DIRECTION * SPEED * 0.01
			get_parent().add_child(child)
		else:
			var child = Asteroid.create_asteroid(SIZE-1, Vector2.RIGHT + Vector2(0, randf_range(-0.8, 0.8)))
			child.position = position
			get_parent().add_child(child)


func hit(damage):
	HEALTH -= damage
	if HEALTH <= 0:
		spawn_children()
		IS_DESTROYED = true
		$Sprite.play("default")


func on_screen_exited():
	queue_free()
