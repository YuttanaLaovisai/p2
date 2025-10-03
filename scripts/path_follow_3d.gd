extends PathFollow3D

@export var patrol_speed: float = 2.6
@export var chase_speed: float = 5.0

var is_chasing = false

func _process(delta: float) -> void:
	if is_chasing:
		progress += chase_speed * delta
	else:
		progress += patrol_speed * delta

	# ถ้าไม่ให้วน (loop = false) และถึงจุดสุดท้าย → หยุด
	if not loop and progress_ratio >= 1.0:
		patrol_speed = 0
		chase_speed = 0
