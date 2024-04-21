extends RichTextLabel

func _process(delta):
	self.text = "Score: " + str(get_node("/root/Globals").SCORE)
