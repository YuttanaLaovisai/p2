extends Label

@export var text_to_show: String = "With the last tire and fuel in place, the car sputtered, then growled alive. 
\nAs you drove out of the desolate village, the shadows seemed to follow you. 
\nYou escaped… but the silence lingers in your mind."
@export var speed: float = 1   # ค่าพื้นฐาน (วินาที/ตัวอักษร)

var typing := false

func _ready():
	start_typing(text_to_show)
	await get_tree().create_timer(14).timeout
	get_tree().change_scene_to_file("res://scenes/start.tscn")

func start_typing(new_text: String):
	text_to_show = new_text
	text = ""
	typing = true
	typewriter()

func typewriter() -> void:
	var i = 0
	while i < text_to_show.length():
		text += text_to_show[i]

		# ตั้ง delay แบบเปลี่ยนตามตัวอักษร
		var delay = speed
		var c = text_to_show[i]
		if c == " ":
			delay = speed * 0.5        # เว้นวรรคสั้นลง
		elif c == "." or c == ",":
			delay = speed * 3.0        # จุดหรือจุลภาคหยุดนานขึ้น
		else:
			delay = randf_range(speed * 0.8, speed * 1.2)  # สุ่มเล็กน้อยให้ดูไม่เป็นหุ่นยนต์

		await get_tree().create_timer(delay).timeout
		i += 1

	typing = false
