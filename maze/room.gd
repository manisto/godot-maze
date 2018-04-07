var openings = {};
var neighbors = {};

func _init():
	pass
	
func connected():
	return self.openings.values().has(true);
	
func addNeighbor(direction, neighbor):
	self.openings[direction] = false;
	self.neighbors[direction] = neighbor;