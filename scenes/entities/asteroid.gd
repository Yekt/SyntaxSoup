extends Area2D
class_name Asteroid


const LARGE = 2
const MEDIUM = 1
const SMALL = 0
const ASTEROID = preload("res://scenes/entities/asteroid.tscn")
var GLOBALS


var SIZE
var DIRECTION
var SPEED
var HEALTH
var CHILDREN_COUNT


static func create_asteroid(size: int, direction: Vector2) -> Asteroid:
	direction = direction.normalized()
	var speed_randomizer = randf_range(0.8, 1.2)
	var asteroid = ASTEROID.instantiate()
	if (size <= SMALL):
		asteroid.scale = Vector2(0.2, 0.2)
		asteroid.SIZE = SMALL
		asteroid.SPEED = 600 * speed_randomizer
		asteroid.HEALTH = 1
		asteroid.CHILDREN_COUNT = 0
	elif (size == MEDIUM):
		asteroid.scale = Vector2(0.4, 0.4)
		asteroid.SIZE = MEDIUM
		asteroid.SPEED = 400 * speed_randomizer
		asteroid.HEALTH = 2
		asteroid.CHILDREN_COUNT = 3
	else: 
		asteroid.scale = Vector2(0.6, 0.6)
		asteroid.SIZE = LARGE
		asteroid.SPEED = 200 * speed_randomizer
		asteroid.HEALTH = 4
		asteroid.CHILDREN_COUNT = 3
	asteroid.DIRECTION = direction
	return asteroid


func _ready():
	GLOBALS = get_node("/root/Globals")
	SPEED *= GLOBALS.SPEED_SCALE


func _process(delta):
	position = position + DIRECTION * SPEED * delta
	for object in get_overlapping_bodies():
		object.hit(1)
		HEALTH = -1
	if HEALTH <= 0:
		spawn_children()
		queue_free()


func spawn_children():
	for i in CHILDREN_COUNT:
		var child = Asteroid.create_asteroid(SIZE-1, Vector2.RIGHT + Vector2(0, randf_range(-0.6, 0.6)))
		child.position = self.position
		get_parent().add_child(child)


func hit(damage):
	HEALTH -= damage
