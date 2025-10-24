extends CharacterBody3D

@onready var pivot = $Pivot
@onready var camera = $Pivot/Camera3D
@onready var raycast = $Pivot/Camera3D/RayCast3D
@onready var crosshair = $crosshair2
@onready var part = $VBoxContainer2/part
@onready var stamina_bar = $ProgressBar
@onready var hold_point = $Pivot/Camera3D/HoldItem     # จุดที่ถือของ
var yaw = 0.0
var pitch = 0.0

@export var max_stamina = 100
var stamina = max_stamina
@export var stamina_regen = 20
@export var stamina_drain = 50

@export var walk_speed = 2
@export var run_speed = 4
var current_speed = walk_speed

var can_run = true
var is_running = false
var is_jumping = false
var sens
var current_item: Node3D = null    # ของที่ถืออยู่ตอนนี้


# =====================================================
func _ready() -> void:
	$Pivot/Camera3D/RayCast3D.collision_mask &= ~(1 << 1)
	if Engine.has_singleton("GlobalSens"):
		sens = GlobalSens.get_sensitivity()
	else:
		sens = 0.02
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	stamina_bar.max_value = max_stamina

# =====================================================
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# =====================================================
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sens * 0.5
		pitch -= event.relative.y * sens * 0.5
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(90))
		rotation.y = yaw
		pivot.rotation.x = pitch

# =====================================================
func _process(delta: float) -> void:
	sens = GlobalSens.get_sensitivity()

	# ==== ปุ่ม R เพื่อหลุดจากจุดติด ====
	if Input.is_action_just_pressed("r"):
		var offset_dirs = [
			Vector3(1, 0, 0),
			Vector3(-1, 0, 0),
			Vector3(0, 0, 1),
			Vector3(0, 0, -1),
			Vector3(1, 0, 1).normalized(),
			Vector3(-1, 0, -1).normalized(),
			Vector3(-1, 0, 1).normalized(),
			Vector3(1, 0, -1).normalized(),
		]
		for dir in offset_dirs:
			var new_pos = global_transform.origin + dir * 0.5
			var test_transform = Transform3D(global_transform.basis, new_pos)
			if not test_move(test_transform, Vector3.ZERO):
				global_transform.origin = new_pos
				print("✅ Unstuck to:", new_pos)
				break

	# ==== ระบบ UI Key และ Objective ====
	if GlobalInventory.attic != 0 or GlobalInventory.basement != 0:
		$VBoxContainer/key.visible = true
		if GlobalInventory.basement != 0:
			$VBoxContainer/basement.visible = true
		if GlobalInventory.attic != 0:
			$VBoxContainer/attic.visible = true

	if !Globalkey.is_on:
		$VBoxContainer2/objective.visible = false
		$VBoxContainer2/part.visible = false
	else:
		$VBoxContainer2/objective.visible = true
		$VBoxContainer2/part.visible = true

	part.text = "Find all the car parts \n– Tires: " + str(GlobalInventory.tire) + "/4\n– Fuel: " + str(GlobalInventory.fuel) + "/1\n– Engine: " + str(GlobalInventory.v8) + "/1"

	# ==== ระบบวิ่ง ====
	if Input.is_action_pressed("shift") and stamina > 0 and can_run:
		if !is_running:
			$AudioStreamPlayer3D.pitch_scale *= 1.5
		is_running = true
	else:
		if is_running:
			$AudioStreamPlayer3D.pitch_scale /= 1.5
		is_running = false

# =====================================================
func _physics_process(delta: float) -> void:

	stamina_bar.visible = stamina < max_stamina
	stamina_bar.value = stamina
	
	if IsHolding.is_holding:
		can_run = false
		walk_speed = 1
	else:
		can_run = true
		walk_speed = 2
	
	if is_running:
		stamina -= stamina_drain * delta
		if stamina <= 0:
			stamina = 0
			is_running = false
			$AudioStreamPlayer3D.pitch_scale /= 1.5
	else:
		if stamina < max_stamina:
			stamina += stamina_regen * delta

	current_speed = run_speed if is_running else walk_speed

	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	if Input.is_action_just_pressed("space") and is_on_floor():
		is_jumping = true
		velocity.y = 4.5

	if not is_on_floor() and !is_jumping and velocity.y < 0:
		is_jumping = true

	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if input_dir != Vector2.ZERO:
		if !$AudioStreamPlayer3D.playing:
			$AudioStreamPlayer3D.play()
	else:
		$AudioStreamPlayer3D.stop()

	velocity.x = direction.x * current_speed
	velocity.z = direction.z * current_speed
	move_and_slide()

	# ==== ตรวจจับวัตถุที่ interact ได้ ====
	var collision = raycast.get_collider()
	if raycast.is_colliding() and collision != null and collision.has_method("interact"):
		crosshair.visible = true
		if Input.is_action_just_pressed("click"):
			collision.interact()
			GlobalSound.play_sound("res://assets/item-pickup-37089.mp3")
	else:
		crosshair.visible = false
	

func hold_item(scene: PackedScene):
	if current_item:
		current_item.queue_free()
	var new_item = scene.instantiate()
	hold_point.add_child(new_item)
	new_item.transform.origin = Vector3.ZERO
	current_item = new_item
	IsHolding.is_holding = true
	IsHolding.can_hold = false
	print("🧤 ถือของแล้ว:", scene)
	print("isHolding ", IsHolding.is_holding)
	print("canHolding ", IsHolding.can_hold)

func drop_item():
	if current_item:
		current_item.queue_free()
		current_item = null
		IsHolding.is_holding = false
		IsHolding.can_hold = true
		print("🗑️ ของในมือถูกลบออกแล้ว")
	else:
		print("❌ ไม่มีของในมือให้ลบ")
