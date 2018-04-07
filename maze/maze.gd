var Room = load("res://maze/room.gd");
enum Directions { UP, RIGHT, DOWN, LEFT };
enum Opposites { UP = Directions.DOWN, RIGHT = LEFT, DOWN = UP, LEFT = RIGHT };
enum Dx { UP = 0, RIGHT = 1, DOWN = 0, LEFT = -1 };
enum Dy { UP = -1, RIGHT = 0, DOWN = 1, LEFT = 0 };

var rooms = {};
var width;
var height;

func _init(width, height):		
	self.width = width;
	self.height = height;
	initialize_rooms();
	add_neighbors();
	
func initialize_rooms():
	for x in range(self.width):
		for y in range(self.height):
			var coordinates = Vector2(x, y);
			self.rooms[coordinates] = Room.new();
			

func add_neighbors():
	for x in range(self.width):
		for y in range(self.height):
			var coordinates = Vector2(x, y);
			var room = self.rooms[coordinates];
			
			for direction in Directions:
				var delta = Vector2(Dx[direction], Dy[direction]);
				var neighbor = self.rooms[coordinates + delta] if self.rooms.has(coordinates + delta) else null
				room.addNeighbor(Directions[direction], neighbor);

func connect(room, direction):
	var opposite = (direction + 2) % 4;
	var connected_room = room.neighbors[direction];
	room.openings[direction] = true;
	connected_room.openings[opposite] = true;
	
func output():
	var result = "";
	
	for top in range((self.width * 2) + 1):
		result += "_"
	
	for y in range(self.height):
			result += "\n|"
			
			for x in range(self.width):
				var room = self.rooms[Vector2(x, y)]
				var openings = room.openings
				
				result += " " if Directions.DOWN in room.openings and room.openings[Directions.DOWN] else "_"
				result += " " if Directions.RIGHT in room.openings and room.openings[Directions.RIGHT] else "|"
	
	print(result);
	
	
	