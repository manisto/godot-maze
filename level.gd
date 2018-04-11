extends Node2D

var Maze = load("res://maze/maze.gd")
var RC = load("res://maze/recursive-backtracker.gd")
var UP = Maze.UP
var RIGHT = Maze.RIGHT
var DOWN = Maze.DOWN
var LEFT = Maze.LEFT

func _ready():
	var maze = Maze.new(15, 8)
	var rc = RC.new(maze, 0, 0)
	rc.generate()
	maze.output()
	render_tiles(maze)

func render_tiles(maze):
	var map = get_node("TileMap")
	var tileset = map.get_tileset()
	
	for y in range(maze.height + 1):
		for x in range(maze.width + 1):
			var topLeft = maze.room(Vector2(x - 1, y - 1))
			var topRight = maze.room(Vector2(x, y -1))
			var bottomLeft = maze.room(Vector2(x - 1, y))
			var bottomRight = maze.room(Vector2(x, y))
			
			var topLeftTile = "wall_top_"
			var topRightTile = "wall_top_coco"
			var bottomLeftTile = "wall_top_ococ"
			
			topLeftTile += "o" if wall(topLeft, RIGHT) or wall(topRight, LEFT) else "c"
			topLeftTile += "o" if wall(topRight, DOWN) or wall(bottomRight, UP) else "c"
			topLeftTile += "o" if wall(bottomRight, LEFT) or wall(bottomLeft, RIGHT) else "c"
			topLeftTile += "o" if wall(bottomLeft, UP) or wall(topLeft, DOWN) else "c"
			
			var tile = tileset.find_tile_by_name(topLeftTile)
			map.set_cell(x * 2, y * 2, tile)
			
			tile = tileset.find_tile_by_name(topRightTile)
			
			if wall(bottomRight, UP) or wall(topRight, DOWN):
				map.set_cell((x * 2) + 1, y * 2, tile)
				
			tile = tileset.find_tile_by_name(bottomLeftTile)
			
			if wall(bottomRight, LEFT) or wall(bottomLeft, RIGHT):
				map.set_cell(x * 2, (y * 2) + 1, tile)

func wall(room, direction):
	if room == null:
		return false
	
	return !room.is_open(direction)