extends Node

var mouse_sensitivity: float = 0.002

func set_sensitivity(value: float) -> void:
	mouse_sensitivity = clamp(value, 0.001, 0.005)

func get_sensitivity() -> float:
	return mouse_sensitivity


func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("control", "mouse_sensitivity", mouse_sensitivity)
	cfg.save("user://control_settings.cfg")

func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://control_settings.cfg") == OK:
		if cfg.has_section_key("control", "mouse_sensitivity"):
			mouse_sensitivity = float(cfg.get_value("control", "mouse_sensitivity"))
