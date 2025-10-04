extends Node3D

@export_enum("basement", "attic") var key_type: String = "basement"

@onready var alert = $alert
@onready var open_sound = $open
@onready var close_sound = $close
var is_open = false

@export var red: float = 90.0   # มุมเปิด (องศา)
@export var def: float = 0.0    # มุมปิด (องศา)
@export var open_speed: float = 2.0   # ความเร็วหมุน

func _ready() -> void:
	alert.text = "\"Need " + key_type + " key\""

func interact():
	var has_key := false
	
	match key_type:
		"basement":
			has_key = GlobalInventory.basement > 0
		"attic":
			has_key = GlobalInventory.attic > 0

	if not has_key:
		alert.visible = true
		$lock.play()
		await get_tree().create_timer(1).timeout
		alert.visible = false
		return

	if not is_open:
		open_sound.play()
		await rotate_door_to(deg_to_rad(red))  # เปิด
		is_open = true
	else:
		await rotate_door_to(deg_to_rad(def))  # ปิด
		close_sound.play()                      # ✅ เล่นเสียงหลังปิดสนิท
		is_open = false


func rotate_door_to(target_angle: float) -> void:
	while abs(rotation.y - target_angle) > 0.01:
		rotation.y = lerp(rotation.y, target_angle, get_process_delta_time() * open_speed)
		await get_tree().process_frame
	rotation.y = target_angle
