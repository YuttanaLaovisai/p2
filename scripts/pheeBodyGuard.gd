extends CharacterBody3D

@export var pathfollow: PathFollow3D   # ลาก PathFollow3D มาที่ Inspector
@export var speed: float = 0.5
@onready var anim = $phee/AnimationPlayer
@onready var audio = $AudioStreamPlayer3D
@export var sounds: Array[AudioStream]   # ลากไฟล์เสียงเข้ามาใน Inspector
@export var min_delay: float = 2.0       # ดีเลย์ต่ำสุด (วินาที)
@export var max_delay: float = 3.0       # ดีเลย์สูงสุด (วินาที)

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	play_random_loop()

func play_random_loop():
	if sounds.size() == 0:
		return

	# สุ่มเสียง
	var index = rng.randi_range(0, sounds.size() - 1)
	audio.stream = sounds[index]
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()

	# ตั้งเวลาเล่นรอบถัดไป
	var next_delay = rng.randf_range(min_delay, max_delay)
	await get_tree().create_timer(next_delay).timeout
	play_random_loop()


func _physics_process(delta: float) -> void:
	if !anim.is_playing():
		anim.play("Armature_001|mixamo_com|Layer0")
	if pathfollow:
		pathfollow.progress += speed * delta
		global_transform.origin = pathfollow.global_transform.origin
		var forward = -pathfollow.transform.basis.z
		#var target_basis = Basis.looking_at(forward, Vector3.UP)
		#var new_basis = global_transform.basis.slerp(target_basis, delta * 3.0)
		#global_transform.basis = new_basis.orthonormalized()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		call_deferred("_do_change_scene")

func _do_change_scene():
	get_tree().change_scene_to_file("res://scenes/jumpscare.tscn")
