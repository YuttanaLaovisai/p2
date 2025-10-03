extends Node3D

func _ready() -> void:
	SceneTransition.play_anim()
	await get_tree().create_timer(3).timeout
	SceneTransition.chang_scene("res://scenes/start.tscn")
