extends Camera3D

@export var shake_strength: float = 0.05
@export var shake_speed: float = 2

var time_passed: float = 0.0
var base_transform: Transform3D

func _ready():
	base_transform = global_transform

func _process(delta: float):
	time_passed += delta * shake_speed

	var offset_x = sin(time_passed) * shake_strength
	var offset_y = cos(time_passed * 1.3) * shake_strength
	var offset_z = sin(time_passed * 0.7) * shake_strength * 0.5

	var t = base_transform
	t.origin += Vector3(offset_x, offset_y, offset_z)
	global_transform = t
