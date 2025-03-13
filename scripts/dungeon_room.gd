extends Node2D

func setDoors(left, right, top, bottom):
	if left:
		$leftDoor/wall.visible = false
	if right:
		$rightDoor/wall.visible = false
	if top:
		$topDoor/wall.visible = false
	if bottom:
		$bottomDoor/wall.visible = false

func openDoors(left, right, top, bottom):
	if left:
		$leftDoor.visible = false
		$leftDoor/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	if right:
		$rightDoor.visible = false
		$rightDoor/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	if top:
		$topDoor.visible = false
		$topDoor/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	if bottom:
		$bottomDoor.visible = false
		$bottomDoor/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
