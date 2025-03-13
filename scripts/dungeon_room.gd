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
