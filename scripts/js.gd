extends Area3D

#func _on_js1_body_entered(body: Node3D) -> void:
	#print("entered:", body.name)
	#if body.is_in_group("player"):
		#print("p")
		#$"../phee".dash_forward()


func _on_body_entered(body: Node3D) -> void:
	print("entered:", body.name)
	if body.is_in_group("player"):
		print("p")
		$"../phee".dash_forward()
		await  get_tree().create_timer(0.2).timeout
		$"../phee".queue_free()
