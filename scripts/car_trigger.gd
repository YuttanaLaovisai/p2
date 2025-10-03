extends StaticBody3D

@onready var alert = $"../alert"

func interact():
	#SceneTransition.chang_scene("res://scenes/ending.tscn")
	if GlobalInventory.fuel != 1 and GlobalInventory.tire != 4:
		$AudioStreamPlayer3D.play()
		alert.visible = true
		await get_tree().create_timer(2).timeout
		alert.visible = false
	else:
		SceneTransition.chang_scene("res://scenes/ending.tscn")
