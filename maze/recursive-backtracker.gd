var maze
var x
var y
var stack = []

func _init(maze, x, y):
	self.maze = maze
	self.x = x
	self.y = y
	
func generate():
	randomize()
	self.stack.push_back(Vector2(self.x, self.y))
	
	while self.stack.size() > 0:
		var location = self.stack.back()
		var direction = choose_random_direction(location)
		
		if direction == null:
			self.stack.pop_back()
			continue
			
		self.maze.connect(location, direction)
		location = self.maze.delta(location, direction)
		self.stack.push_back(location)

func choose_random_direction(location):
	var directions = []
	
	for direction in maze.directions(location):
		var neighbor = self.maze.neighbor(location, direction)
		
		if not neighbor.connected():
			directions.append(direction)
	
	if directions.size() == 0:
		return null
		
	var random_index = randi() % directions.size()
	return directions[random_index]