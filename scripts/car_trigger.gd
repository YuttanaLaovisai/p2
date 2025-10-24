extends StaticBody3D
@onready var alert = $"../alert"

func interact():
	
	var player = get_tree().get_first_node_in_group("player")
	print("DEBUG >> IsHolding =", IsHolding.is_holding)
	if IsHolding.is_holding:
		# ถ้ามีของในมือ → ลบทิ้ง
		if IsHolding.item_name == "tire":
			GlobalInventory.tire += 1
		elif IsHolding.item_name == "fuel":
			GlobalInventory.fuel += 1
		elif IsHolding.item_name == "v8":
			GlobalInventory.v8 += 1
			
		player.drop_item()

		# ตรวจของครบหรือยัง
		if GlobalInventory.fuel == 1 and GlobalInventory.tire == 4 and GlobalInventory.v8 == 1:
			GlobalSound.play_sound("res://assets/car-engine-start-44357.mp3")
			SceneTransition.chang_scene("res://scenes/ending.tscn")
		else:
			alert.visible = true
			alert.text = "Part installed! Keep finding the rest."
			await get_tree().create_timer(2).timeout
			alert.visible = false
	else:
		if !alert.visible:
			alert.visible = true
			GlobalSound.play_sound("res://assets/car-engine-ignition-fail-352768.mp3")
			alert.text = "You have nothing to install!"
			await get_tree().create_timer(2).timeout
			alert.visible = false
