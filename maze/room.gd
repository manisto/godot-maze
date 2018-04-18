var openings = 0

func _init():
	pass
	
func connected():
	return self.openings > 0
	
func open(direction):
	self.openings |= direction
	
func is_open(direction):
	return self.openings & direction > 0