extends CharacterBody3D

# ======== ตั้งค่าใน Inspector ========
@export var pathfollow: PathFollow3D          # ลาก PathFollow3D มาวาง
@export var walk_speed: float = 0.5            # ความเร็วปกติ
@export var chase_speed: float = 4.0            # ความเร็วตอนไล่
@export var detect_distance: float = 10.0       # ระยะตรวจจับ (ถ้าไม่มี Area3D จะใช้ค่านี้แทน)

@onready var anim = $phee/AnimationPlayer
@onready var audio = $AudioStreamPlayer3D
@export var sounds: Array[AudioStream]
@export var min_delay: float = 2.0
@export var max_delay: float = 3.0

# ======== ตัวแปรภายใน ========
var rng = RandomNumberGenerator.new()
var player: Node3D = null
var chasing: bool = false
var start_pos: Vector3   # จำตำแหน่งเริ่มต้นไว้

# ======== ฟังก์ชันเริ่มต้น ========
func _ready():
	rng.randomize()
	start_pos = global_transform.origin
	play_random_loop()

# ======== เล่นเสียงแบบสุ่ม ========
func play_random_loop():
	if sounds.size() == 0:
		return
	var index = rng.randi_range(0, sounds.size() - 1)
	audio.stream = sounds[index]
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	var next_delay = rng.randf_range(min_delay, max_delay)
	await get_tree().create_timer(next_delay).timeout
	play_random_loop()

# ======== การเคลื่อนไหวหลัก ========
func _physics_process(delta: float) -> void:
	if !anim.is_playing():
		anim.play("Armature_001|mixamo_com|Layer0")

	# ==== ถ้าไล่ผู้เล่น ====
	if chasing and player:
		var dir = (player.global_transform.origin - global_transform.origin).normalized()
		velocity = dir * chase_speed
		move_and_slide()
		look_at(player.global_transform.origin, Vector3.UP)
		$phee/AnimationPlayer.speed_scale = 5.0

	# ==== ถ้าไม่ได้ไล่ ====
	elif pathfollow:
		pathfollow.progress += walk_speed * delta
		global_transform.origin = pathfollow.global_transform.origin
		var forward = -pathfollow.transform.basis.z
		look_at(global_transform.origin + forward, Vector3.UP)
		$phee/AnimationPlayer.speed_scale = 1

# ======== ตรวจจับผู้เล่นด้วย Area3D ========
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		chasing = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == player:
		chasing = false

func _on_area_3d_2_body_entered(body: Node3D) -> void: 
	if body.is_in_group("player"): 
		call_deferred("_do_change_scene") 

func _do_change_scene(): 
	get_tree().change_scene_to_file("res://scenes/jumpscare.tscn")
