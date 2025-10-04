extends StaticBody3D

# ===== ให้เลือกใน Inspector ได้ =====
@export_enum("basement", "attic") var key_type: String = "basement"

func interact():
	GlobalSound.play_sound("res://assets/item-pickup-37089.mp3")

	# ตรวจสอบชนิดกุญแจแล้วเพิ่มเข้า inventory
	match key_type:
		"basement":
			GlobalInventory.basement += 1
		"attic":
			GlobalInventory.attic += 1

	queue_free()
	
