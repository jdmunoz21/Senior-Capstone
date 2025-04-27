extends Node2D

var tile_types = {
	"island_nsew" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_nse" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["water", "island_nsw", "island_bridges_ns", "island_west", "island_north", "island_south"]},
	
	"island_nsw" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["water", "island_nse", "island_bridges_ns", "island_east", "island_north", "island_south"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_ewn" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["water", "island_ews", "island_bridges_ew", "island_east", "island_west", "island_south"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_ews" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_bridges_ew" : {"N" : ["water", "island_east", "island_west", "island_north", "island_en", "island_ewn", 
	"island_wn", "island_bridges_ew"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["water", "island_east", "island_west", "island_south", "island_es", "island_ews", "island_ws", "island_bridges_ew"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_bridges_ns" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["water", "island_east", "island_en", "island_es", "island_nse", "island_bridges_ns", "island_north", 
	"island_south"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_east", "island_nsw", "island_wn",
	"island_ws"]},
	
	"island_en" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["water", "island_bridges_ew", "island_es", "island_ews", "island_south", "island_east", "island_west",
	"island_ws"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	"island_ws"]},
	
	"island_es" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_wn",
	"island_ewn", "island_en"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	 "island_ws"]},
	
	"island_wn" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["water", "island_bridges_ns", "island_north", "island_south", "island_east", "island_en", "island_es",
	"island_nse"], 
	"S": ["water", "island_bridges_ew", "island_east", "island_west", "island_south", "island_ews", "island_es",
	"island_ws"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_ws" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_ewn",
	"island_wn"], 
	"E" : ["water", "island_bridges_ns", "island_east", "island_south", "island_north", "island_nse", "island_en", 
	"island_es"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_east" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_ewn",
	"island_wn"], 
	"E" : ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"], 
	"S": ["water", "island_bridges_ew", "island_east", "island_west", "island_south", "island_ews", "island_es",
	"island_ws"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	 "island_ws"]},
	
	"island_west" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_ewn",
	"island_wn"], 
	"E" : ["water", "island_bridges_ns", "island_east", "island_south", "island_north", "island_nse", "island_en", 
	"island_es"], 
	"S": ["water", "island_bridges_ew", "island_east", "island_west", "island_south", "island_ews", "island_es",
	"island_ws"], 
	"W" : ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]},
	
	"island_south" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_ewn",
	"island_wn"], 
	"E" : ["water", "island_bridges_ns", "island_east", "island_south", "island_north", "island_nse", "island_en", 
	"island_es"], 
	"S": ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	 "island_ws"]},
	
	"island_north" : {"N" : ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"], 
	"E" : ["water", "island_bridges_ns", "island_east", "island_south", "island_north", "island_nse", "island_en", 
	"island_es"], 
	"S": ["water", "island_bridges_ew", "island_east", "island_west", "island_south", "island_ews", "island_es",
	"island_ws"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	 "island_ws"]},
	
	"water" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_ewn",
	"island_wn"], 
	"E" : ["water", "island_bridges_ns", "island_east", "island_south", "island_north", "island_nse", "island_en", 
	"island_es"], 
	"S": ["water", "island_bridges_ew", "island_east", "island_west", "island_south", "island_ews", "island_es",
	"island_ws"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	 "island_ws"]},
	
	"island_water" : {"N" : ["water", "island_bridges_ew", "island_east", "island_west", "island_north", "island_ewn",
	"island_wn"], 
	"E" : ["water", "island_bridges_ns", "island_east", "island_south", "island_north", "island_nse", "island_en", 
	"island_es"], 
	"S": ["water", "island_bridges_ew", "island_east", "island_west", "island_south", "island_ews", "island_es",
	"island_ws"], 
	"W" : ["water", "island_bridges_ns", "island_north", "island_south", "island_west", "island_nsw", "island_wn",
	 "island_ws"]}
}

const GRID_WIDTH = 15
const GRID_HEIGHT = 15

var grid = []

var rng = RandomNumberGenerator.new()

var Player = preload("res://scenes/characters/player.tscn")
var Camera = preload("res://scenes/room_transition_camera.tscn")
var label = preload("res://scenes/wfc_village_process_label.tscn")
var player = null
var camera = null
var start_room = null
var rooms_that_require_doors = ["floor", "chest", "bones"]

var island_bridges_ew = preload('res://scenes/rooms_tiles/island/island_bridges_ew.tscn')
var island_bridges_ns = preload('res://scenes/rooms_tiles/island/island_bridges_ns.tscn')
var island_east = preload('res://scenes/rooms_tiles/island/island_east.tscn')
var island_en = preload('res://scenes/rooms_tiles/island/island_en.tscn')
var island_es = preload('res://scenes/rooms_tiles/island/island_es.tscn')
var island_ewn = preload('res://scenes/rooms_tiles/island/island_ewn.tscn')
var island_ews= preload('res://scenes/rooms_tiles/island/island_ews.tscn')
var island_north = preload('res://scenes/rooms_tiles/island/island_north.tscn')
var island_nse = preload('res://scenes/rooms_tiles/island/island_nse.tscn')
var island_nsew = preload('res://scenes/rooms_tiles/island/island_nsew.tscn')
var island_nsw = preload('res://scenes/rooms_tiles/island/island_nsw.tscn')
var island_south = preload('res://scenes/rooms_tiles/island/island_south.tscn')
var water = preload('res://scenes/rooms_tiles/island/island_water.tscn')
var island_west = preload('res://scenes/rooms_tiles/island/island_west.tscn')
var island_wn = preload('res://scenes/rooms_tiles/island/island_wn.tscn')
var island_ws = preload('res://scenes/rooms_tiles/island/island_ws.tscn')
var island_water = preload('res://scenes/rooms_tiles/island/island_scattered.tscn')

var regions = []

var doorValues = []
var roomInstances = []
var labelGrid = []
var labelInstances = []
var fixed_tiles = []

var paused = false

@onready var timer = $Timer

var animationOrder = []

var tiles_with_north_paths = ["island_bridges_ns", "island_en", "island_ewn", "island_north", "island_nse", "island_nsew", "island_nsw",
	"island_wn"]

var tiles_with_east_paths = ["island_bridges_ew", "island_east", "island_en", "island_es", "island_ews", "island_nse", "island_nsew",
	"island_ewn"]

var tiles_with_south_paths = ["island_bridges_ns", "island_es", "island_ews", "island_nsew", "island_nse", "island_nsw",
	"island_south", "island_ws"]

var tiles_with_west_paths = ["island_bridges_ew", "island_ewn", "island_ews", "island_nsew", "island_nsw", "island_west", 
	"island_wn", "island_ws"]
	
var timing = 0

func _ready():
	ready_dungeon()
	
func clear_screen():
	for i in animationOrder:
		remove_child(roomInstances[i[0]][i[1]])
		remove_child(labelGrid[i[0]][i[1]])
		
func ready_dungeon():
	if camera != null:
		camera.enabled = false
	$Camera2D.enabled = true
	await clear_screen()
	await initialize_grid()
	await set_labels()
		
func setup_dungeon():
	await set_grid_by_labels()
	await collapse_wave_function()
	await fix_animation_order()
	await check_adjacent_tiles()
	await instantiate_tiles()
	await set_player()
	await find_start_room()
	
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
			
func set_player():
	remove_child(player)
	remove_child(camera)
	player = null
	camera = null
	player = Player.instantiate()
	add_child(player)
	camera = Camera.instantiate()
	add_child(camera)
	
func set_grid_by_labels():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if labelGrid[x][y].text != 'NULL':
				grid[x][y] = [labelGrid[x][y].text, labelGrid[x][y].text]
				fixed_tiles.append([x,y,labelGrid[x][y].text])
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if camera != null:
			if camera.enabled:
				camera.enabled = false
				$Camera2D.enabled = true
			else:
				camera.enabled = true
				$Camera2D.enabled = false
			
	if Input.is_action_just_pressed("pause_game"):
		if paused:
			paused = false
			timer.paused = false
		else:
			paused = true
			timer.paused = true
	
	if event.is_action_pressed("initiate"):
		await setup_dungeon()
		
	if event.is_action_pressed("ready dungeon"):
		await ready_dungeon()
		
	if event.is_action_pressed("switch scenes"):
		get_tree().change_scene_to_file('res://scenes/rooms_tiles/village.tscn')
	
func initialize_grid():
	grid = []
	roomInstances = []
	for x in range(GRID_WIDTH):
		grid.append([])
		roomInstances.append([])
		doorValues.append([])
		for y in range(GRID_HEIGHT):
			grid[x].append(["island_nsew", "island_bridges_ew", "island_bridges_ns", "island_east", "island_en",
			"island_es", "island_ewn", "island_ews", "island_north", "island_nse", "island_nsw", "island_south",
			"island_west", "water", "island_wn", "island_ws", "island_water"])
			roomInstances[x].append([])
			doorValues[x].append([])
		
func set_labels():
	labelGrid = []
	for x in range(GRID_WIDTH):
		labelGrid.append([])
		for y in range(GRID_HEIGHT):
			var label_instance = label.instantiate()
			label_instance.position = Vector2(x*2880,y*1596)
			labelGrid[x].append(label_instance)
			
			add_child(label_instance)
			
func fix_animation_order():
	for x in GRID_WIDTH:
		for y in GRID_HEIGHT:
			if [x,y] not in animationOrder:
				animationOrder.append([x,y])
			
func collapse_wave_function():
	animationOrder = []
	
	var random_x = rng.randi_range(0, GRID_WIDTH-1)
	var random_y = rng.randi_range(0, GRID_HEIGHT-1)
	var random_tile_picked = false
	
	while not is_fully_collapsed():
		var min_entropy = INF
		var min_entropy_cell = null
		
		for x in range(GRID_WIDTH):
			for y in range(GRID_HEIGHT):
				var options = grid[x][y]
				if len(options) > 1 and len(options) < min_entropy:
					min_entropy = len(options)
					min_entropy_cell = Vector2(x,y)
				elif len(options) > 1 and len(options) == min_entropy:
					if not random_tile_picked:
						min_entropy = len(grid[random_x][random_y])
						min_entropy_cell = Vector2(random_x,random_y)
						random_tile_picked = true
		
		if min_entropy_cell == null:
			break
			
		var x = int(min_entropy_cell.x)
		var y = int(min_entropy_cell.y)
		grid[x][y] = [grid[x][y][rng.randi() % len(grid[x][y])]]
		
		await propogate_constraints(x,y)
		
		animationOrder.append([x,y])

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
			
			for option in neighbor_options:
				var allowed_tiles = tile_types[option][opposite_direction(direction)]
				
				if current_tile in allowed_tiles:
					valid_options.append(option)
			
			if len(valid_options) > 0:
				grid[nx][ny] = valid_options
			else:
				var choice = rng.randi_range(1,100)
				if choice % 2 == 0:
					grid[nx][ny] = ["island_water"]
				else:
					grid[nx][ny] = ["water"]

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
	for i in animationOrder:
		for tile in fixed_tiles:
			grid[tile[0]][tile[1]] = [tile[2]]
		var tile_name = grid[i[0]][i[1]][0]
		var tile_scene = null
		if tile_name == "island_water":
			tile_scene = island_water
		elif tile_name == "island_bridges_ew":
			tile_scene = island_bridges_ew
		elif tile_name == "island_bridges_ns":
			tile_scene = island_bridges_ns
		elif tile_name == "island_east":
			tile_scene = island_east
		elif tile_name == "island_en":
			tile_scene = island_en
		elif tile_name == "island_es":
			tile_scene = island_es
		elif tile_name == "island_ewn":
			tile_scene = island_ewn
		elif tile_name == "island_ews":
			tile_scene = island_ews
		elif tile_name == "island_north":
			tile_scene = island_north
		elif tile_name == "island_nse":
			tile_scene = island_nse
		elif tile_name == "island_nsew":
			tile_scene = island_nsew
		elif tile_name == "island_nsw":
			tile_scene = island_nsw
		elif tile_name == "island_south":
			tile_scene = island_south
		elif tile_name == "island_west":
			tile_scene = island_west
		elif tile_name == "island_wn":
			tile_scene = island_wn
		elif tile_name == "island_ws":
			tile_scene = island_ws
		else:
			tile_scene = water
		var tile_instance = tile_scene.instantiate()
		tile_instance.position = Vector2(i[0] * 2880, i[1] * 1596)
		add_child(tile_instance)
		roomInstances[i[0]][i[1]] = tile_instance
		
		if timing % 3 == 0:
			timer.start()
			await timer.timeout
		
		timing += 1

func find_start_room():
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			if grid[x][y][0] == "residential":
				start_room = Vector2((x * 2880) + 200, (y * 1596) + 200)

func check_adjacent_tiles():
	for tile in fixed_tiles:
		grid[tile[0]][tile[1]] = [tile[2]]
			
	for x in (GRID_WIDTH):
		for y in (GRID_HEIGHT):
			if grid[x][y][0] == "water" or grid[x][y][0] == "island_water":
				var north_path = false
				var east_path = false
				var south_path = false
				var west_path = false
				
				if y > 0:
					var north_tile = grid[x][y-1][0]
					if north_tile in tiles_with_south_paths:
						north_path = true
				if x > 0:
					var west_tile = grid[x-1][y][0]
					if west_tile in tiles_with_east_paths:
						west_path = true
				if x < GRID_WIDTH - 1:
					var east_tile = grid[x+1][y][0]
					if east_tile in tiles_with_west_paths:
						east_path = true
				if y < GRID_HEIGHT - 1:
					var south_tile = grid[x][y+1][0]
					if south_tile in tiles_with_north_paths:
						south_path = true
						
				if north_path:
					grid[x][y][0] = "island_north"
				
				if east_path:
					grid[x][y][0] = "island_east"
					
				if south_path:
					grid[x][y][0] = "island_south"
				
				if west_path:
					grid[x][y][0] = "island_west"
						
				if north_path and south_path:
					grid[x][y][0] = "island_bridges_ns" 
					
				if north_path and east_path:
					grid[x][y][0] = "island_en"
				
				if north_path and west_path:
					grid[x][y][0] = "island_wn"
				
				if south_path and east_path:
					grid[x][y][0] = "island_es"
				
				if south_path and west_path:
					grid[x][y][0] = "island_ws"
					
				if east_path and west_path:
					grid[x][y][0] = "island_bridges_ew"
					
				if north_path and east_path and west_path:
					grid[x][y][0] = "island_ewn"
				
				if north_path and south_path and east_path:
					grid[x][y][0] = "island_nse"
				
				if north_path and south_path and west_path:
					grid[x][y][0] = "island_nsw"
				
				if south_path and east_path and west_path:
					grid[x][y][0] = "island_ews"
				
				if north_path and south_path and east_path and west_path:
					grid[x][y][0] = "island_nsew"
					
				if not north_path and not south_path and not east_path and not west_path:
					grid[x][y][0] = "water"
