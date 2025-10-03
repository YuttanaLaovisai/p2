extends Node3D

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("js")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/dead.tscn")
