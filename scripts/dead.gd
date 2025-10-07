extends Node3D

func _ready() -> void:
	SceneTransition.play_anim()
	await get_tree().create_timer(3).timeout
	GlobalInventory.attic = 0
	GlobalInventory.basement = 0
	GlobalInventory.fuel = 0
	GlobalInventory.tire = 0
	GlobalInventory.v8 = 0
	SceneTransition.chang_scene("res://scenes/start.tscn")
