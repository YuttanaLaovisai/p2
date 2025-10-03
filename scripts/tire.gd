extends StaticBody3D

func interact():
	GlobalSound.play_sound("res://assets/item-pickup-37089.mp3")
	GlobalInventory.tire += 1
	queue_free()
