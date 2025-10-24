extends StaticBody3D
@export var item_scene: PackedScene   # scene ของของที่ถือในมือ

func interact():
	IsHolding.item_name = "tire"
	if IsHolding.can_hold and not IsHolding.is_holding:
		GlobalSound.play_sound("res://assets/item-pickup-37089.mp3")

		var player = get_tree().get_first_node_in_group("player")
		if player and item_scene:
			player.hold_item(item_scene)
			print("🛞 เก็บของแล้ว ตอนนี้ถืออยู่ในมือ")
			queue_free()
		else:
			push_warning("❗ item_scene ยังไม่ได้กำหนดใน Inspector!")
