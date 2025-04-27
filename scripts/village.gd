extends Node2D

var tile_types = {
	"center" : {"N" : ["grass", "forest", "farm_path"], 
	"E" : ["residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "bush_path", "light_path", "inn_path", "flower_path"], 
	"S": ["grass", "forest", "bush_path", "forest_path", "flower_path"], 
	"W" : ["residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "deforested_path", "flower_path"]},
	
	"residential" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "commercial_2", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"],
	 "E" : ["center", "residential", "residential_2", "residential_3", "commercial", "commercial_2", "grass_path", "farm_path", "light_path", "inn_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["center", "residential", "residential_2", "residential_3", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "bush_path", "forest_path", "deforested_path", "flower_path"]},
	
	"residential_2" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "light_path", "inn_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "bush_path", "forest_path", "deforested_path", "flower_path"]},
	
	"residential_3" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["grass", "forest", "forest_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["grass", "forest"]},
	
	"commercial" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "light_path", "inn_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "bush_path", "forest_path", "deforested_path", "flower_path"]},
	
	"commercial_2" : {"N" : ["grass", "forest", "farm_path", "light_path", "mining_path", "center"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "light_path", "bush_path", "inn_path", "flower_path"], 
	"S": ["grass", "forest", "flower_path", "bush_path", "forest_path", "center"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "deforested_path", "flower_path"]},
	
	"grass" : {"N" : ["center", "commerical_2", "forest", "grass", "farm_path", "mining_path", "light_path"], 
	"E" : ["residential_3", "forest", "grass", "mining_path", "forest_path", "deforested_path"], 
	"S": ["center", "commerical_2", "forest", "grass", "bush_path", "forest_path", "flower_path"], 
	"W" : ["residential_3", "forest", "grass", "bush_path", "light_path", "inn_path"]},
	
	"grass_path" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "bush_path", "light_path", "inn_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "deforested_path", "flower_path"]},
	
	"forest" : {"N" : ["center", "commerical_2", "forest", "grass", "farm_path", "mining_path", "light_path"], 
	"E" : ["residential_3", "forest", "grass", "mining_path", "forest_path", "deforested_path"], 
	"S": ["center", "commerical_2", "forest", "grass", "bush_path", "forest_path", "flower_path"], 
	"W" : ["residential_3", "forest", "grass", "bush_path", "light_path", "inn_path"]},
	
	"farm_path" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "light_path", "inn_path", "flower_path"], 
	"S": ["center", "commerical_2", "forest", "grass", "forest_path"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "bush_path", "forest_path", "deforested_path", "flower_path"]},
	
	"mining_path" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "bush_path", "light_path", "inn_path", "flower_path"], 
	"S": ["center", "commerical_2", "forest", "grass"], 
	"W" : ["residential_3", "forest", "grass"]},
	
	"bush_path" : {"N" : ["center", "commerical_2", "forest", "grass", "farm_path"], 
	"E" : ["forest", "grass", "mining_path", "residential_3", "deforested_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "deforested_path", "inn_path"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "inn_path", "flower_path"]},
	
	"light_path" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["forest", "grass", "mining_path", "residential_3", "deforested_path"], 
	"S": ["forest", "grass", "center"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "inn_path", "flower_path"]},
	
	"forest_path" : {"N" : ["forest", "grass", "center", "commercial_2"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "bush_path", "light_path", "inn_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["forest", "grass", "center", "residential_3"]},
	
	"deforested_path" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "bush_path", "light_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["forest", "grass", "center", "residential_3", "bush_path", "light_path"]},
	
	"inn_path" : {"N" : ["residential", "residential_2", "residential_3", "commercial", "grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"], 
	"E" : ["forest", "grass", "residential_3", "mining_path", "forest_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "deforested_path", "flower_path"]},

	"flower_path" : {"N" : ["forest", "grass", "commercial_2", "center", "light_path", "mining_path"], 
	"E" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "bush_path", "light_path", "inn_path", "flower_path"], 
	"S": ["residential", "residential_2", "residential_3", "commercial", "grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"], 
	"W" : ["center", "residential", "residential_2", "commercial", "commercial_2", "grass_path", "farm_path", "mining_path", "forest_path", "deforested_path", "flower_path"]}
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

var center = preload("res://scenes/rooms_tiles/village_center.tscn")
var residential = preload("res://scenes/rooms_tiles/residential_center.tscn")
var residential_2 = preload("res://scenes/rooms_tiles/residential_center_2.tscn")
var residential_3 = preload("res://scenes/rooms_tiles/residential_center_3.tscn")
var commercial = preload("res://scenes/rooms_tiles/commercial_center.tscn")
var commercial_2 = preload("res://scenes/rooms_tiles/commercial_center_2.tscn")
var grass = preload("res://scenes/rooms_tiles/grass.tscn")
var grass_path = preload("res://scenes/rooms_tiles/grass_path.tscn")
var forest = preload("res://scenes/rooms_tiles/forest.tscn")
var farm_path = preload("res://scenes/rooms_tiles/farm_path.tscn")
var mining_path = preload("res://scenes/rooms_tiles/mining_path.tscn")
var bush_path = preload("res://scenes/rooms_tiles/bush_path.tscn")
var light_path = preload('res://scenes/rooms_tiles/light_path.tscn')
var forest_path = preload('res://scenes/rooms_tiles/forest_path.tscn')
var deforested_path = preload('res://scenes/rooms_tiles/deforested_path.tscn')
var inn_path = preload('res://scenes/rooms_tiles/inn_path.tscn')
var flower_path = preload('res://scenes/rooms_tiles/flower_path.tscn')
var north_path = preload('res://scenes/rooms_tiles/north_path.tscn')
var east_path = preload("res://scenes/rooms_tiles/east_path.tscn")
var south_path = preload("res://scenes/rooms_tiles/south_path.tscn")
var west_path = preload('res://scenes/rooms_tiles/west_path.tscn')

var regions = []

var doorValues = []
var roomInstances = []
var labelGrid = []
var labelInstances = []
var fixed_tiles = []

var paused = false

@onready var timer = $Timer

var animationOrder = []

var tiles_with_north_paths = ["residential", "residential_2", "residential_3", "commercial",
"grass_path", "farm_path", "mining_path", "light_path", "deforested_path", "inn_path"]

var tiles_with_east_paths = ["center", "residential", "residential_2", "commercial", "commercial_2",
"grass_path", "farm_path", "mining_path", "forest_path", "deforested_path", "flower_path"]

var tiles_with_south_paths = ["residential", "residential_2", "residential_3", "commercial",
"grass_path", "bush_path", "forest_path", "deforested_path", "inn_path", "flower_path"]

var tiles_with_west_paths = ["center", "residential", "residential_2", "commercial", "commercial_2",
"grass_path", "farm_path", "bush_path", "light_path", "inn_path", "flower_path"]

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
		get_tree().change_scene_to_file('res://scenes/rooms_tiles/dungeon.tscn')
	
func initialize_grid():
	grid = []
	roomInstances = []
	for x in range(GRID_WIDTH):
		grid.append([])
		roomInstances.append([])
		doorValues.append([])
		for y in range(GRID_HEIGHT):
			grid[x].append(["center", "residential", "residential_2", "residential_3", 
			"commercial", "commercial_2", "grass_path", "grass", "forest", "farm_path", 
			"mining_path", "bush_path", "light_path", "forest_path", "deforested_path", 
			"inn_path", "flower_path"])
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
					grid[nx][ny] = ["grass"]
				else:
					grid[nx][ny] = ["forest"]

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
		if tile_name == "center":
			tile_scene = center
		elif tile_name == "residential":
			tile_scene = residential
		elif tile_name == "residential_2":
			tile_scene = residential_2	
		elif tile_name == "residential_3":
			tile_scene = residential_3
		elif tile_name == "commercial":
			tile_scene = commercial
		elif tile_name == "commercial_2":
			tile_scene = commercial_2
		elif tile_name == "grass":
			tile_scene = grass
		elif tile_name == "grass_path":
			tile_scene = grass_path
		elif tile_name == "farm_path":
			tile_scene = farm_path
		elif tile_name == "mining_path":
			tile_scene = mining_path
		elif tile_name == "bush_path":
			tile_scene = bush_path
		elif tile_name == "light_path":
			tile_scene = light_path
		elif tile_name == "forest_path":
			tile_scene = forest_path
		elif tile_name == "deforested_path":
			tile_scene = deforested_path
		elif tile_name == "inn_path":
			tile_scene = inn_path
		elif tile_name == "flower_path":
			tile_scene = flower_path
		elif tile_name == "north_path":
			tile_scene = north_path
		elif tile_name == "east_path":
			tile_scene = east_path
		elif tile_name == "south_path":
			tile_scene = south_path
		elif tile_name == "west_path":
			tile_scene = west_path
		else:
			tile_scene = forest
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
			if grid[x][y][0] == "forest" or grid[x][y][0] == "grass":
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
					grid[x][y][0] = "south_path"
				
				if east_path:
					grid[x][y][0] = "west_path"
					
				if south_path:
					grid[x][y][0] = "north_path"
				
				if west_path:
					grid[x][y][0] = "east_path"
						
				if north_path and south_path:
					grid[x][y][0] = "residential_3" 
					
				if north_path and east_path:
					grid[x][y][0] = "mining_path"
				
				if north_path and west_path:
					grid[x][y][0] = "light_path"
				
				if south_path and east_path:
					grid[x][y][0] = "forest_path"
				
				if south_path and west_path:
					grid[x][y][0] = "bush_path"
					
				if east_path and west_path:
					grid[x][y][0] = "commercial_2"
					
				if north_path and east_path and west_path:
					grid[x][y][0] = "farm_path"
				
				if north_path and south_path and east_path:
					grid[x][y][0] = "deforested_path"
				
				if north_path and south_path and west_path:
					grid[x][y][0] = "inn_path"
				
				if south_path and east_path and west_path:
					grid[x][y][0] = "flower_path"
				
				if north_path and south_path and east_path and west_path:
					grid[x][y][0] = "residential"
					
				if not north_path and not south_path and not east_path and not west_path:
					grid[x][y][0] = "grass"
