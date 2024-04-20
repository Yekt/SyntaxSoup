# resolution scaling: https://www.youtube.com/watch?v=blPqie3Z_F0

extends Node2D


var GLOBALS


func _ready():
	GLOBALS = get_node("/root/Globals")


func _physics_process(delta):
	pass
