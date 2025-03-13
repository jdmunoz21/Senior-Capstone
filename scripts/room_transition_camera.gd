extends Camera2D

@onready var screenSize: Vector2 = get_viewport_rect().size
@onready var player = get_parent().get_node("player")

func _ready():
	print(screenSize)
	set_screen_position()
	await get_tree().process_frame
	position_smoothing_enabled = true
	position_smoothing_speed = 7.0
	
func _process(delta: float) -> void:
	set_screen_position()
	
func set_screen_position():
	var playerPosition = player.global_position
	var x = floor(playerPosition.x / screenSize.x) * screenSize.x + screenSize.x / 2
	var y = floor(playerPosition.y / screenSize.y) * screenSize.y + screenSize.y / 2
	global_position = Vector2(x, y)
