extends CanvasLayer

@onready var pause_menu = $"."

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			resume_game()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pause_game()

func pause_game():
	get_tree().paused = true
	pause_menu.visible = true
	pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS   # ✅ ให้เมนูทำงานตอน pause

func resume_game():
	get_tree().paused = false
	pause_menu.visible = false
	pause_menu.process_mode = Node.PROCESS_MODE_INHERIT  # ✅ กลับไปค่าปกติ

func _on_resume_pressed() -> void:
	resume_game()

func _on_reset_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	# ถ้ามี SceneTransition ของคุณเอง
	#SceneTransition.change_scene("res://scenes/main.tscn")
	# หรือใช้ของ Godot โดยตรง
	 #get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start.tscn")
