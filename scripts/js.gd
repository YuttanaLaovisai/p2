extends Area3D

@export var target: Node

@export var show_time = 0.2

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if target != null:
			target.visible = true
			target.dash_forward()
			target.play_sound(show_time)
			await  get_tree().create_timer(show_time).timeout
			target.queue_free()
