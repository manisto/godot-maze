extends Node2D

var Maze = load("res://maze/maze.gd")
var RC = load("res://maze/recursive-backtracker.gd")

func _ready():
	var maze = Maze.new(10, 10)
	var rc = RC.new(maze, 0, 0)
	rc.generate()
	maze.output()
	render_tiles(maze)

func render_tiles(maze):
	var map = get_node("TileMap")
	var tileset = map.get_tileset()
	
	for y in range(maze.height):
		for x in range(maze.width):
			var location = Vector2(x, y)
			var room = maze.rooms[location]
			var up = maze.neighbor(location, Maze.UP)
			var left = maze.neighbor(location, Maze.LEFT)
			
			var tile = "wall_top_"
			
			if up == null or up.is_open(Maze.LEFT) == true:
				tile += "c"
			else:
				tile += "o"
				
			if room.is_open(Maze.UP) == true:
				tile += "c"
			else:
				tile += "o"
			
			if room.is_open(Maze.LEFT) == true:
				tile += "c"
			else:
				tile += "o"
				
			if left == null or left.is_open(Maze.UP) == true:
				tile += "c"
			else:
				tile += "o"
			
			var the_tile = tileset.find_tile_by_name(tile)
			map.set_cell(x * 2, y * 2, the_tile)
			
			the_tile = tileset.find_tile_by_name("wall_top_coco")
			
			if room.is_open(Maze.UP) == false:
				map.set_cell((x * 2) + 1, y * 2, the_tile)
				
			the_tile = tileset.find_tile_by_name("wall_top_ococ")
			
			if room.is_open(Maze.LEFT) == false:
				map.set_cell(x * 2, (y * 2) + 1, the_tile)