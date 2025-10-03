extends CanvasLayer

@onready var fade_rect = $Fade

func fade_out(duration: float = 1.5) -> void:
	fade_rect.modulate = Color(0, 0, 0, 0)  # เริ่มโปร่งใส
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate", Color(0, 0, 0, 1), duration)
	await tween.finished
