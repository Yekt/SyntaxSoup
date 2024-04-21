extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	%Score.text = "Verloren!\nScore: " + str(get_node("/root/Globals").SCORE)

func _on_pressed():
	pass # Replace with function body.
