extends Label

var rooms = ["center", "residential", "residential_2", "residential_3", 
			"commercial", "commercial_2", "grass_path", "grass", "forest", "farm_path", 
			"mining_path", "bush_path", "light_path", "forest_path", "deforested_path", 
			"inn_path", "flower_path"]
var room = 'null'
var current_room = -1

var center_image = preload('res://assets/media/village_center.jpeg')
var residential_image = preload('res://assets/media/residential.jpeg')
var residential_2_image = preload('res://assets/media/residential_2.jpeg')
var residential_3_image = preload('res://assets/media/residential_3.jpeg')
var commercial_image = preload("res://assets/media/commercial.jpeg")
var commercial_2_image = preload("res://assets/media/commercial_2.jpeg")
var grass_path_image = preload('res://assets/media/grass_path.jpeg')
var grass_image = preload('res://assets/media/grass.jpeg')
var forest_image = preload('res://assets/media/forest.jpeg')
var farm_path_image = preload('res://assets/media/farm_path.jpeg')
var mining_path_image = preload('res://assets/media/mining_path.jpeg')
var bush_path_image = preload('res://assets/media/bush_path.jpeg')
var light_path_image = preload('res://assets/media/light_path.jpeg')
var forest_path_image = preload('res://assets/media/forest_path.jpeg')
var deforested_path_image = preload('res://assets/media/deforested_path.jpeg')
var inn_path_image = preload('res://assets/media/inn_path.jpeg')
var flower_path_image = preload('res://assets/media/flower_path.jpeg')

var images = [center_image, residential_image, residential_2_image, residential_3_image,
commercial_image, commercial_2_image, grass_path_image, grass_image, forest_image,
farm_path_image, mining_path_image, bush_path_image, light_path_image, forest_path_image,
deforested_path_image, inn_path_image, flower_path_image]

func _on_change_room_button_pressed() -> void:
	current_room += 1
	$roomPreview.texture = images[current_room % len(images)]
	$roomPreview.visible = true
	text = rooms[current_room % len(rooms)]
