extends Area2D
class_name Asteroid


const LARGE = 2
const MEDIUM = 1
const SMALL = 0
const RESOURCE = preload("res://entities/resource.tscn")
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


static func create_asteroid(size: int, direction: Vector2, globals) -> Asteroid:
	# TODO calling load on every spawn is inefficient
	# however calling preload() leads to recursive import which the editor doesn't like ("corrupt file")
	# consider storing a reference to asteroid.tscn in global game state
	var ASTEROID = load("res://entities/asteroid.tscn")
	direction = direction.normalized()
	var speed_randomizer = randf_range(0.8, 1.2)
	var asteroid = ASTEROID.instantiate()
	if (size <= SMALL):
		asteroid.scale = Vector2(0.2, 0.2)
		asteroid.SIZE = SMALL
		asteroid.SPEED = 250 * speed_randomizer * globals.SPEED_SCALE
		asteroid.HEALTH = 4
		asteroid.CHILDREN_COUNT = randi_range(2,4)
		asteroid.ROTATION = randf_range(2, 2) * globals.SPEED_SCALE
		asteroid.DAMAGE = 10
	elif (size == MEDIUM):
		asteroid.scale = Vector2(0.35, 0.35)
		asteroid.SIZE = MEDIUM
		asteroid.SPEED = 175 * speed_randomizer * globals.SPEED_SCALE
		asteroid.HEALTH = 6
		asteroid.CHILDREN_COUNT = 3
		asteroid.ROTATION = randf_range(-1, 1) * globals.SPEED_SCALE
		asteroid.DAMAGE = 20
	else: 
		asteroid.scale = Vector2(0.5, 0.5)
		asteroid.SIZE = LARGE
		asteroid.SPEED = 100 * speed_randomizer * globals.SPEED_SCALE
		asteroid.HEALTH = 12
		asteroid.CHILDREN_COUNT = 2
		asteroid.ROTATION = randf_range(-0.3, 0.3) * globals.SPEED_SCALE
		asteroid.DAMAGE = 40
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
		if $Sprite.is_playing():
			return
		queue_free()
	for b in get_overlapping_bodies():
		if b.is_dodgeing():
			continue
		b.hit(DAMAGE)
		self.destroy()
		break


func spawn_children():
	if SIZE <= SMALL:
		for i in CHILDREN_COUNT:
			var child = RESOURCE.instantiate()
			child.position = position
			child.velocity = randf_range(0.8, 1.2) * (velocity + Vector2(0, randf_range(-100, 100)))
			get_parent().add_child(child)
	else:
		for i in CHILDREN_COUNT:
			var y_delta = 0.4 + abs(ROTATION) * 0.25
			var child = Asteroid.create_asteroid(SIZE-1, Vector2.RIGHT + Vector2(0, randf_range(-y_delta, y_delta)), GLOBALS)
			child.position = position
			get_parent().add_child(child)


func hit(damage):
	if IS_DESTROYED:
		return
	HEALTH -= damage
	if HEALTH <= 0:
		self.destroy_and_spawn()


func destroy():
	if IS_DESTROYED:
		return
	IS_DESTROYED = true
	DAMAGE = 0
	set_collision_layer_value(4, false)
	set_collision_layer_value(6, false)
	set_collision_mask_value(3, false)
	$Sprite.play("default")
	$AudioStreamPlayer2D.play()


func destroy_and_spawn():
	if IS_DESTROYED:
		return
	destroy()
	spawn_children()


func on_screen_exited():
	queue_free()
