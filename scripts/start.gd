extends Node3D
@onready var option: Control = $CanvasLayer/option

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	option.visible = false

func _process(delta: float) -> void:
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	SceneTransition.chang_scene("res://scenes/main.tscn")


func _on_button_pressed() -> void:
	option.visible = true


func _on_back_pressed() -> void:
	option.visible = false
