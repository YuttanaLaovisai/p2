extends Area3D

var is_js = false

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$js.visible = true
		is_js = true
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		$js.visible = false
