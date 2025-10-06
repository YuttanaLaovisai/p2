extends CanvasLayer

@onready var pause_menu = $"."
@onready var pause: Control = $pause
@onready var option: Control = $option


func _ready() -> void:
	pause_menu.visible = false
	option.visible = false
	pause.visible = false

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
	pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	pause.visible = true
	option.visible = false

func resume_game():
	get_tree().paused = false
	pause_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.process_mode = Node.PROCESS_MODE_INHERIT

# ปุ่ม "เริ่มต่อ" หรือ "เล่นต่อ"
func _on_resume_pressed() -> void:
	resume_game()

# ปุ่ม "ตั้งค่า"
func _on_settings_pressed() -> void:
	option.visible = true
	pause.visible = false

# ปุ่ม "กลับ" จากหน้า option
func _on_back_pressed() -> void:
	option.visible = false
	pause.visible = true

# ปุ่ม "ออก"
func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start.tscn")
