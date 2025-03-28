extends Node2D

var tile_types = {
	"floor" : {"N" : ["floor", "wall"], "E" : ["floor", "wall"], "S": ["floor", "wall"], "W" : ["floor", "wall"]},
	"wall" : {"N" : ["floor", "wall"], "E" : ["floor", "wall"], "S": ["floor", "wall"], "W" : ["floor", "wall"]}
}

const GRID_WIDTH = 17
const GRID_HEIGHT = 15

var grid = []

var rng = RandomNumberGenerator.new()

var floor = preload('res://scenes/rooms_tiles/dungeon_room.tscn')
var wall = preload("res://scenes/rooms_tiles/non_room.tscn")
# var Player = preload("res://character.tscn")
var player = null
var start_room = null

var regions = []

var doorValues = []
var roomInstances = []

func _ready():
	initialize_grid()
	collapse_wave_function()
	check_adjacent_tiles()
	check_edges()
	shape_dungeon()
	connect_unconnected_rooms()
	findRoomDoors()
	instantiate_tiles()
	'''player = Player.instantiate()
	add_child(player)
	find_start_room()
	if start_room != null:
		player.position = start_room'''
	
func _input(event):
	if event.is_action_pressed("ui_select"):
		'''for n in get_children():
			n.queue_free()
			
		initialize_grid()
		collapse_wave_function()
		check_adjacent_tiles()
		check_edges()
		shape_dungeon()
		connect_unconnected_rooms()
		findRoomDoors()
		instantiate_tiles()'''
		
		testOpenDoors()
	
func initialize_grid():
	grid = []
	for x in range(GRID_WIDTH):
		grid.append([])
		for y in range(GRID_HEIGHT):
			grid[x].append(["floor", "wall"])
			
func collapse_wave_function():
	while not is_fully_collapsed():
		var min_entropy = INF
		var min_entropy_cell = null
		
		for x in range(GRID_WIDTH):
			for y in range(GRID_HEIGHT):
				var options = grid[x][y]
				if len(options) > 1 and len(options) < min_entropy:
					min_entropy = len(options)
					min_entropy_cell = Vector2(x,y)
		
		if min_entropy_cell == null:
			break
			
		var x = int(min_entropy_cell.x)
		var y = int(min_entropy_cell.y)
		grid[x][y] = [grid[x][y][rng.randi() % len(grid[x][y])]]
		
		propogate_constraints(x,y)

func propogate_constraints(x, y):
	var current_tile = grid[x][y][0]
	var connections = tile_types[current_tile]
	
	for direction in connections.keys():
		var nx = x
		var ny = y
		
		match direction:
			"N": ny -= 1
			"E": nx += 1
			"S": ny +- 1
			"W": nx -= 1
			
		if nx >= 0 and nx < GRID_WIDTH and ny >= 0 and ny < GRID_HEIGHT:
			var neighbor_options = grid[nx][ny]
			var valid_options = []
			
			for option in neighbor_options:
				if option in tile_types[option][opposite_direction(direction)]:
					valid_options.append(option)
					
			if len(valid_options) > 0:
				grid[nx][ny] = valid_options

func opposite_direction(direction):
	match direction:
		"N" : return "S"
		"E" : return "W"
		"S" : return "N"
		"W" : return "E"

func is_fully_collapsed():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if len(grid[x][y]) > 1:
				return false
	return true
	
func instantiate_tiles():
	roomInstances = []
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var tile_name = grid[x][y][0]
			var tile_scene = null
			if tile_name == "floor":
				tile_scene = floor
			else:
				tile_scene = wall
			var tile_instance = tile_scene.instantiate()
			tile_instance.position = Vector2(x * 176, y * 112)
			add_child(tile_instance)
			roomInstances.append(tile_instance)
			
	for i in range(len(roomInstances)):
		if doorValues[i] != []:
			roomInstances[i].setDoors(doorValues[i][0],
			doorValues[i][1], doorValues[i][2], doorValues[i][3])
	
func find_start_room():
	if grid[1][1][0] != "wall":
		start_room = Vector2(96 + 20, 96 + 20)

func check_adjacent_tiles():
	var left_tile = null
	var right_tile = null
	var top_tile = null
	var bottom_tile = null
	
	var left_tile_good = false
	var right_tile_good = false
	var top_tile_good = false
	var bottom_tile_good = false
	
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] != "wall":
				if x > 0:
					left_tile = grid[x-1][y]
				if x < GRID_WIDTH - 1:
					right_tile = grid[x+1][y]
				if y > 0:
					top_tile = grid[x][y-1]
				if y < GRID_HEIGHT - 1:
					bottom_tile = grid[x][y+1]
			
				if left_tile == null and right_tile == null and top_tile == null and bottom_tile == null:
					grid[x][y][0] = "wall"
					
				if left_tile != null:
					if left_tile[0] != "wall":
						left_tile_good = true
						
				if right_tile != null:
					if right_tile[0] != "wall":
						right_tile_good = true
						
				if top_tile != null:
					if top_tile[0] != "wall":
						top_tile_good = true
						
				if bottom_tile != null:
					if bottom_tile[0] != "wall":
						bottom_tile_good = true
				
				if not top_tile_good and not left_tile_good and not bottom_tile_good and not top_tile_good:
					grid[x][y][0] = "wall"
				
				left_tile = null
				right_tile = null
				top_tile = null
				bottom_tile = null
				left_tile_good = false
				right_tile_good = false
				top_tile_good = false
				bottom_tile_good = false
				
func shape_dungeon():
	var left_tile = null
	var right_tile = null
	var top_tile = null
	var bottom_tile = null
	
	for i in range(GRID_WIDTH):
		for x in range(GRID_WIDTH):
			for y in range(GRID_HEIGHT):
				var stay_score = 0
				
				if grid[x][y][0] != "wall":
					if x > 0:
						left_tile = grid[x-1][y]
					if x < GRID_WIDTH - 1:
						right_tile = grid[x+1][y]
					if y > 0:
						top_tile = grid[x][y-1]
					if y < GRID_HEIGHT - 1:
						bottom_tile = grid[x][y+1]
					
					# print("--------- NEW TILE ---------")
					
						
					var adjacent_tiles = []
					adjacent_tiles.append(left_tile[0])
					adjacent_tiles.append(right_tile[0])
					adjacent_tiles.append(top_tile[0])
					adjacent_tiles.append(bottom_tile[0])
					
					# print(adjacent_tiles)
					
					for z in adjacent_tiles:
						if z == "floor":
							stay_score += 1
						
					# print(stay_score)
						
					if stay_score < 2:
						grid[x][y][0] = "wall"
				
				left_tile = null
				right_tile = null
				top_tile = null
				bottom_tile = null

func check_edges():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if x == 0 or x == GRID_WIDTH - 1:
				grid[x][y][0] = "wall"	
			if y == 0 or y == GRID_HEIGHT - 1:
				grid[x][y][0] = "wall"			

func find_regions():
	var visited = []
	regions.clear()

	for x in range(GRID_WIDTH):
		var column = []
		for y in range(GRID_HEIGHT):
			column.append(false)
		visited.append(column)

	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] == "floor" and not visited[x][y]:
				var region = []
				flood_fill(x, y, visited, region)
				regions.append(region)

func flood_fill(x, y, visited, region):
	var stack = [Vector2(x, y)]

	while stack.size() > 0:
		var cell = stack.pop_back()
		var cx = int(cell.x)
		var cy = int(cell.y)

		if cx < 0 or cx >= GRID_WIDTH or cy < 0 or cy >= GRID_HEIGHT:
			continue

		if visited[cx][cy] or grid[cx][cy][0] != "floor":
			continue

		visited[cx][cy] = true
		region.append(Vector2(cx, cy))

		stack.append(Vector2(cx, cy - 1))  # North
		stack.append(Vector2(cx + 1, cy))  # East
		stack.append(Vector2(cx, cy + 1))  # South
		stack.append(Vector2(cx - 1, cy))  # West

func connect_unconnected_rooms():
	find_regions()

	while regions.size() > 1:
		var region_a = regions.pop_back()
		var closest_cell = null
		var closest_distance = INF
		var closest_target = null
		var closest_region_index = -1

		for target_index in range(regions.size()):
			var region_b = regions[target_index]

			for cell_a in region_a:
				for cell_b in region_b:
					var distance = cell_a.distance_to(cell_b)
					if distance < closest_distance:
						closest_distance = distance
						closest_cell = cell_a
						closest_target = cell_b
						closest_region_index = target_index

		if closest_cell and closest_target:
			carve_corridor(closest_cell, closest_target)
			find_regions()  # Update regions after connecting

func carve_corridor(start, end):
	var x = int(start.x)
	var y = int(start.y)
	var target_x = int(end.x)
	var target_y = int(end.y)

	# Horizontal Path
	while x != target_x:
		if grid[x][y][0] == "wall":
			grid[x][y] = ["floor"]
		x += sign(target_x - x)

	# Vertical Path
	while y != target_y:
		if grid[x][y][0] == "wall":
			grid[x][y] = ["floor"]
		y += sign(target_y - y)

func findRoomDoors():
	doorValues = []
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] == "floor":
				var left_tile = null
				var right_tile = null
				var top_tile = null
				var bottom_tile = null
				
				if x > 0:
					left_tile = grid[x-1][y][0]
				if x < GRID_WIDTH - 1:
					right_tile = grid[x+1][y][0]
				if y > 0:
					top_tile = grid[x][y-1][0]
				if y < GRID_HEIGHT - 1:
					bottom_tile = grid[x][y+1][0]
				
				var roomDoors = []
				
				if left_tile == "floor":
					roomDoors.append(true)
				else:
					roomDoors.append(false)
				
				if right_tile == "floor":
					roomDoors.append(true)
				else:
					roomDoors.append(false)
					
				if top_tile == "floor":
					roomDoors.append(true)
				else:
					roomDoors.append(false)
				
				if bottom_tile == "floor":
					roomDoors.append(true)
				else:
					roomDoors.append(false)
					
				doorValues.append(roomDoors)
			else:
				doorValues.append([])

func testOpenDoors():
	for i in range(len(roomInstances)):
		if doorValues[i] != []:
			print(doorValues[i])
			roomInstances[i].openDoors(doorValues[i][0],
			doorValues[i][1], doorValues[i][2], doorValues[i][3])
