extends Node2D


var GLOBALS
const DEFAULT_SCALE = 1280 # vertical of 720p


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	GLOBALS.SPEED_SCALE = screen_size.x / DEFAULT_SCALE
