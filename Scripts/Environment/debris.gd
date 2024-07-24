extends Node2D

@onready var _pieces : Array[Node] = get_children()

func scatter():
	for pieces in _pieces:
		pieces.visible = true
		pieces.visible = false
		pieces.apply_impulse(pieces.position.normalized() * Global.ppt * 4)
	
