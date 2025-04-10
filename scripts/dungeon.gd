extends Node2D

var tile_types = {
	"floor" : {"N" : ["floor", "wall", "chest", "bones"], "E" : ["floor", "wall", "chest", "bones"], "S": ["floor", "wall", "chest", "bones"], "W" : ["floor", "wall", "chest", "bones"]},
	"wall" : {"N" : ["floor", "wall"], "E" : ["floor", "wall"], "S": ["floor", "wall"], "W" : ["floor", "wall"]},
	"chest" : {"N" : ["floor", "bones"], "E" : ["floor", "bones"], "S": ["floor", "bones"], "W" : ["floor", "bones"]},
	"bones" : {"N" : ["floor", "chest", "bones"], "E" : ["floor", "chest", "bones"], "S": ["floor", "chest", "bones"], "W" : ["floor", "chest", "bones"]}
}

const GRID_WIDTH = 17
const GRID_HEIGHT = 15

var grid = []

var rng = RandomNumberGenerator.new()

var floor = preload('res://scenes/rooms_tiles/dungeon_room_2.tscn')
var wall = preload("res://scenes/rooms_tiles/non_room.tscn")
var h_hall_room = preload("res://scenes/rooms_tiles/hall_room.tscn")
var h_hall = preload('res://scenes/rooms_tiles/horizontal_hallway.tscn')
var chest_room = preload("res://scenes/rooms_tiles/dungeon_room_3.tscn")
var bone_room = preload("res://scenes/rooms_tiles/dungeon_room_4.tscn")
var Player = preload("res://scenes/characters/player.tscn")
var Camera = preload("res://scenes/room_transition_camera.tscn")
var label = preload("res://scenes/wfc_process_label.tscn")
var player = null
var camera = null
var start_room = null
var rooms_that_require_doors = ["floor", "chest", "bones"]

var regions = []

var doorValues = []
var roomInstances = []
var labelGrid = []
var labelInstances = []

var paused = false

@onready var timer = $Timer

func _ready():
	var roomCount = 0
	while roomCount < 10:
		await setup_dungeon()
		roomCount = findRoomCount()
	#testOpenDoors()
	
func clear_screen():
	for child in roomInstances:
		remove_child(child)
	for child in labelInstances:
		remove_child(child)
		
func setup_dungeon():
	if camera != null:
		camera.enabled = false
	$Camera2D.enabled = true
	await clear_screen()
	print('1')
	await initialize_grid()
	print('2')
	await set_labels()
	print('labels now')
	await(get_tree().create_timer(3).timeout)
	await collapse_wave_function()
	print('3')
	check_adjacent_tiles()
	print('4')
	check_edges()
	print('5')
	shape_dungeon()
	print('6')
	connect_unconnected_rooms()
	print('7')
	placeHallways()
	print('8')
	limitChestRooms()
	print('9')
	findRoomDoors()
	print('10')
	await setFinalLabelText()
	await instantiate_tiles()
	print('11')
	#print('tiles instantiated')
	await set_player()
	print('12')
	await find_start_room()
	print('13')
	
	if start_room != null:
		player.position = start_room
		$Camera2D.position = start_room
		await(get_tree().create_timer(0.1).timeout)
		$Camera2D.zoom = Vector2(1,1)
		await(get_tree().create_timer(0.5).timeout)
		camera.set_screen_position()
		camera.enabled = true
		$Camera2D.position = Vector2(0,0)
		$Camera2D.zoom = Vector2(0.067, 0.067)
		$Camera2D.enabled = false
		
	if len(doorValues) != len(roomInstances):
		await(get_tree().create_timer(3).timeout)
		setup_dungeon()
		
func setFinalLabelText():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			labelGrid[x][y].text = grid[x][y][0]
			await(get_tree().create_timer(0.1).timeout)
			
func set_player():
	remove_child(player)
	remove_child(camera)
	player = null
	camera = null
	player = Player.instantiate()
	add_child(player)
	camera = Camera.instantiate()
	add_child(camera)
		
func findRoomCount():
	var roomCount = 0
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] in rooms_that_require_doors:
				roomCount += 1
	return roomCount
	
func _input(event):
	if event.is_action_pressed("doors"):
		testOpenDoors()
	
	if event.is_action_pressed("ui_cancel"):
		if camera != null:
			if camera.enabled:
				camera.enabled = false
				$Camera2D.enabled = true
			else:
				camera.enabled = true
				$Camera2D.enabled = false
			
	if event.is_action_pressed("ui_accept"):
		var roomCount = 0
		while roomCount < 10:
			await setup_dungeon()
			roomCount = findRoomCount()
			
	if Input.is_action_just_pressed("pause_game"):
		if paused:
			paused = false
			timer.paused = false
		else:
			paused = true
			timer.paused = true
	
func initialize_grid():
	grid = []
	for x in range(GRID_WIDTH):
		grid.append([])
		for y in range(GRID_HEIGHT):
			grid[x].append(["floor", "wall", "chest", "bones"])
		
func set_labels():
	labelGrid = []
	for x in range(GRID_WIDTH):
		labelGrid.append([])
		for y in range(GRID_HEIGHT):
			var label_instance = label.instantiate()
			label_instance.position = Vector2(x*2880,y*1596)
			labelGrid[x].append(label_instance)
			labelInstances.append(label_instance)
			label_instance.text = '''
			floor
			wall
			chest
			bones'''
			
			add_child(label_instance)
			
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
		print([grid[x][y][rng.randi() % len(grid[x][y])]])
		
		await propogate_constraints(x,y)
		
		'''labelGrid[x][y].text = ''
		for option in grid[x][y]:
			labelGrid[x][y].text += option + "\n"
			
		await(get_tree().create_timer(0.1).timeout)'''

func propogate_constraints(x, y):
	var current_tile = grid[x][y][0]
	var connections = tile_types[current_tile]
	
	for direction in connections.keys():
		var nx = x
		var ny = y
		
		match direction:
			"N": ny -= 1
			"E": nx += 1
			"S": ny += 1
			"W": nx -= 1
			
		if nx >= 0 and nx < GRID_WIDTH and ny >= 0 and ny < GRID_HEIGHT:
			var neighbor_options = grid[nx][ny]
			var valid_options = []
			
			'''labelGrid[nx][ny].text = ''
			for option in neighbor_options:
				labelGrid[nx][ny].text += option + "\n"
				
			await(get_tree().create_timer(0.1).timeout)'''
			
			for option in neighbor_options:
				var allowed_tiles = tile_types[option][opposite_direction(direction)]
				
				if current_tile in allowed_tiles:
					valid_options.append(option)
			
			'''labelGrid[nx][ny].text = ''
			if len(valid_options) > 0:
				for option in valid_options:
					labelGrid[nx][ny].text += option + "\n"
			else:
				labelGrid[nx][ny].text = 'wall'
				
			await(get_tree().create_timer(0.1).timeout)'''
			
			if len(valid_options) > 0:
				grid[nx][ny] = valid_options
			else:
				grid[nx][ny] = ["wall"]

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
			elif tile_name == "h_hall_room":
				tile_scene = h_hall_room
			elif tile_name == "h_hall":
				tile_scene = h_hall	
			elif tile_name == "chest":
				tile_scene = chest_room
			elif tile_name == "bones":
				tile_scene = bone_room
			else:
				tile_scene = wall
			var tile_instance = tile_scene.instantiate()
			tile_instance.position = Vector2(x * 2880, y * 1596)
			add_child(tile_instance)
			roomInstances.append(tile_instance)
			timer.start()
			await timer.timeout
	
	if len(roomInstances) == len(doorValues):
		for i in range(len(roomInstances)):
			if doorValues[i] != []:
				roomInstances[i].setDoors(doorValues[i][0],
				doorValues[i][1], doorValues[i][2], doorValues[i][3])
	
func find_start_room():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] == "floor":
				start_room = Vector2((x * 2880) + 200, (y * 1596) + 200)

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
			if grid[x][y][0] in rooms_that_require_doors and not visited[x][y]:
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

		if visited[cx][cy] or grid[cx][cy][0] not in rooms_that_require_doors:
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
			find_regions()

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
			if grid[x][y][0] in rooms_that_require_doors:
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
				
				if left_tile in rooms_that_require_doors or left_tile == "h_hall" or left_tile == "h_hall_room":
					roomDoors.append(true)
				else:
					roomDoors.append(false)
				
				if right_tile in rooms_that_require_doors or right_tile == "h_hall" or right_tile == "h_hall_room":
					roomDoors.append(true)
				else:
					roomDoors.append(false)
					
				if top_tile in rooms_that_require_doors:
					roomDoors.append(true)
				else:
					roomDoors.append(false)
				
				if bottom_tile in rooms_that_require_doors:
					roomDoors.append(true)
				else:
					roomDoors.append(false)
					
				doorValues.append(roomDoors)
			else:
				doorValues.append([])

func testOpenDoors():
	for i in range(len(roomInstances)):
		if doorValues[i] != []:
			roomInstances[i].openDoors(doorValues[i][0],
			doorValues[i][1], doorValues[i][2], doorValues[i][3])

func placeHallways():
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
				
				if left_tile == "floor" and right_tile == "floor":
					var chance_of_hallway = rng.randi_range(0,100)
					if chance_of_hallway <= 20:
						grid[x][y][0] = "h_hall_room"
					if chance_of_hallway > 20 and chance_of_hallway <= 50:
						grid[x][y][0] = "h_hall"
						
func limitChestRooms():
			
	var chestAmount = 0
	
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] == "chest":
				chestAmount += 1
	
	while chestAmount > 3:			
		for x in range(GRID_WIDTH):
			for y in range(GRID_HEIGHT):
				if grid[x][y][0] == "chest":
					grid[x][y][0] = "floor"
		
		chestAmount = 0
	
		for x in range(GRID_WIDTH):
			for y in range(GRID_HEIGHT):
				if grid[x][y][0] == "chest":
					chestAmount += 1
		
