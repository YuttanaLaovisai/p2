extends Control



func _on_jump_pressed() -> void:
	GlobalSignal.jump_pressed.emit()


func _on_unstruct_pressed() -> void:
	GlobalSignal.unstruct.emit()
