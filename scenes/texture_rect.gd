extends Control

signal look_input(delta: Vector2)

var is_looking := false
var last_pos := Vector2.ZERO

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and get_global_rect().has_point(event.position):
			is_looking = true
			last_pos = event.position
		elif not event.pressed:
			is_looking = false

	elif event is InputEventScreenDrag and is_looking:
		var delta = event.relative
		look_input.emit(delta)


func _on_look_input(delta: Vector2) -> void:
	GlobalSignal.look.emit()
