extends Label

var rooms = ['wall', 'floor', 'chest', 'bones', 'h_hall', 'h_hall_room']
var room = 'null'
var current_room = -1

var wall_image = preload('res://assets/media/wall.jpeg')
var floor_image = preload('res://assets/media/dungeon_room.jpeg')
var chest_image = preload('res://assets/media/chest_room.jpeg')
var bones_image = preload('res://assets/media/bones_room.jpeg')
var h_hall_image = preload('res://assets/media/h_hall.jpeg')
var h_hall_room_image = preload('res://assets/media/h_hall_room.jpeg')

var images = [wall_image, floor_image, chest_image, bones_image, h_hall_image, h_hall_room_image]

func _on_change_room_button_pressed() -> void:
	current_room += 1
	$roomPreview.texture = images[current_room % len(images)]
	$roomPreview.visible = true
	text = rooms[current_room % len(rooms)]
