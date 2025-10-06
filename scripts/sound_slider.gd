extends HSlider

@export var audio: String = "Master"

func _ready() -> void:
	value = GlobalSound.get_volume(audio)

func _on_value_changed(value: float) -> void:
	GlobalSound.set_volume(audio, value)
