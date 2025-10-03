extends StaticBody3D


func interact():
	GlobalSound.play_sound("res://assets/item-pickup-37089.mp3")
	GlobalInventory.fuel += 1
	queue_free()
