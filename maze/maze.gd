var Room = load("res://maze/room.gd")

const UP = "UP"
const RIGHT = "RIGHT"
const DOWN = "DOWN"
const LEFT = "LEFT"
const Directions = [UP, RIGHT, DOWN, LEFT]
const Dx = { UP = 0, RIGHT = 1, DOWN = 0, LEFT = -1 }
const Dy = { UP = -1, RIGHT = 0, DOWN = 1, LEFT = 0 }
const Opposites = { UP = DOWN, RIGHT = LEFT, DOWN = UP, LEFT = RIGHT }

var rooms = {}
var width
var height

func _init(width, height):
	self.width = width
	self.height = height
	initialize_rooms()
	
func initialize_rooms():
	for x in range(self.width):
		for y in range(self.height):
			var coordinates = Vector2(x, y)
			self.rooms[coordinates] = Room.new()

func connect(location, direction):
	var room = self.room(location)
	var connected_room = self.neighbor(location, direction)
	room.open(direction)
	connected_room.open(Opposites[direction])

func neighbor(location, direction):
	var delta = self.delta(location, direction)
	return self.room(delta)

func delta(location, direction):
	return Vector2(location.x + Dx[direction], location.y + Dy[direction])

func room(location):
	if not self.valid(location):
		return null
	
	return self.rooms[location]

func valid(location):
	if location.x < 0 or location.x >= width:
		return false
	
	if location.y < 0 or location.y >= height:
		return false
	
	return true

func directions(location):
	var directions = []
	
	for direction in Directions:
		var neighbor = self.neighbor(location, direction)
		
		if neighbor != null:
			directions.append(direction)
	
	return directions

func output():
	var result = ""
	
	for top in range((self.width * 2) + 1):
		result += "_"
	
	for y in range(self.height):
			result += "\n|"
			
			for x in range(self.width):
				var room = self.room(Vector2(x, y))
				var openings = room.openings
				
				result += " " if room.is_open(DOWN) else "_"
				result += " " if room.is_open(RIGHT) else "|"
	
	print(result)