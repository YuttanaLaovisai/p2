extends CharacterBody3D

@export var speed: float = 5.0
@export var dash_speed: float = 30.0
@export var dash_time: float = 0.3

var is_dashing = false
var dash_timer = 0.0

func _physics_process(delta: float) -> void:
	if !$phee/AnimationPlayer.is_playing():
		$phee/AnimationPlayer.play("Armature_001|mixamo_com|Layer0")
		#$phee/AnimationPlayer.playback_speed = 2
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func dash_forward():
	is_dashing = true
	dash_timer = dash_time
	velocity = transform.basis.z * dash_speed
