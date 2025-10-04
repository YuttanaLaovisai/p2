extends CharacterBody3D

@export var speed: float = 5.0
@export var dash_speed: float = 30.0
@export var dash_time: float = 0.3

# ======== เลือกทิศจาก Inspector ========
enum DashDirection { FORWARD, BACKWARD, LEFT, RIGHT }
@export var dash_direction: DashDirection = DashDirection.FORWARD

var is_dashing = false
var dash_timer = 0.0

func _physics_process(delta: float) -> void:
	if !$phee/AnimationPlayer.is_playing(): 
		$phee/AnimationPlayer.play("Armature_001|mixamo_com|Layer0")
		$phee/AnimationPlayer.speed_scale = 5.0
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func play_sound(time: float):
	$audio.play()
	await  get_tree().create_timer(time).timeout
	$audio.stop()

func dash_forward():
	is_dashing = true
	dash_timer = dash_time

	match dash_direction:
		DashDirection.FORWARD:
			velocity = -transform.basis.z * dash_speed
		DashDirection.BACKWARD:
			velocity = transform.basis.z * dash_speed
		DashDirection.LEFT:
			velocity = -transform.basis.x * dash_speed
		DashDirection.RIGHT:
			velocity = transform.basis.x * dash_speed
