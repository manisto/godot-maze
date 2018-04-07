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
	var starting_room = self.maze.rooms[Vector2(self.x, self.y)]
	self.stack.push_back(starting_room)
	
	while self.stack.size() > 0:
		var room = self.stack.back()
		var direction = choose_random_direction(room)
		
		if direction == null:
			self.stack.pop_back()
			continue
			
		self.maze.connect(room, direction)
		room = room.neighbors[direction]
		self.stack.push_back(room)
	
	self.maze.output()

func choose_random_direction(room):
	var directions = possible_directions(room)
	
	if directions.size() == 0:
		return null
		
	var random_index = randi() % directions.size()
	return directions[random_index]

func possible_directions(room):
	var directions = []
	
	for direction in room.neighbors.keys():
		var neighbor = room.neighbors[direction]
		
		if neighbor != null and not neighbor.connected():
			directions.append(direction)
	
	return directions