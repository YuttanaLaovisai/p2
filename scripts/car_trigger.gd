extends StaticBody3D

@onready var alert = $"../alert"

func interact():
	if GlobalInventory.fuel == 1 and GlobalInventory.tire == 4 and GlobalInventory.v8 == 1:
		GlobalSound.play_sound("res://assets/car-engine-start-44357.mp3")
		SceneTransition.change_scene("res://scenes/ending.tscn")
	else:
		$AudioStreamPlayer3D.play()
		alert.visible = true
		await get_tree().create_timer(2).timeout
		alert.visible = false
