var openings = {}

func _init():
	pass
	
func connected():
	return self.openings.values().has(true)
	
func open(direction):
	self.openings[direction] = true
	
func is_open(direction):
	return self.openings[direction] if self.openings.has(direction) else false