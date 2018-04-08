extends Node2D

var Maze = load("res://maze/maze.gd")
var RC = load("res://maze/recursive-backtracker.gd")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	build_level()
	#render_tiles()

func build_level():
	var maze = Maze.new(2, 2)
	var rc = RC.new(maze, 0, 0)
	rc.generate()
	maze.output()
	
func render_tiles(maze):
	var map = get_node("TileMap")
	var tileset = map.get_tileset()
	
	for y in range(maze.height):
		for x in range(maze.width):
			var coords = Vector2(x, y)
			var room = maze.rooms[coords]
			var up = maze.neighbor(coords, 'UP')
			var left = maze.neighbor(coords, 'LEFT')
			
			var tile = "wall_top_"
			
			if up == null or up.is_open('UP') == true:
				tile += "c"
			else:
				tile += "o"
				
			if room.is_open('UP') == true:
				tile += "c"
			else:
				tile += "o"
			
			if room.openings[3] == true:
				tile += "c"
			else:
				tile += "o"
				
			if left == null or left.openings[0] == true:
				tile += "c"
			else:
				tile += "o"
			
			var the_tile = tileset.find_tile_by_name(tile)
			map.set_cell(x * 2, y * 2, the_tile)
			
			the_tile = tileset.find_tile_by_name("wall_top_coco");
			
			if room.openings[0] == false:
				map.set_cell((x * 2) + 1, y * 2, the_tile)
				
			the_tile = tileset.find_tile_by_name("wall_top_ococ");
			
			if room.openings[3] == false:
				map.set_cell(x * 2, (y * 2) + 1, the_tile)