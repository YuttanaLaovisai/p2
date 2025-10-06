extends HSlider

func _ready() -> void:
	value = GlobalSens.get_sensitivity()

func _on_value_changed(value: float) -> void:
	GlobalSens.set_sensitivity(value)
