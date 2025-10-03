extends Node3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta: float) -> void:
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	SceneTransition.chang_scene("res://scenes/main.tscn")
