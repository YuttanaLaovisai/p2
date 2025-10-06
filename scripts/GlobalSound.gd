extends Node

@onready var player = AudioStreamPlayer.new()

# เก็บค่าของแต่ละ bus เช่น Master, Music, SFX
var volumes := {
	"Master": 0.0,
	"Music": 0.0,
	"SFX": 0.0
}

func _ready():
	add_child(player)

# 🔊 ฟังก์ชันเล่นเสียง
func play_sound(path: String, bus_name: String = "SFX"):
	player.stream = load(path)
	player.bus = bus_name
	player.play()

# 🎚️ ฟังก์ชันตั้งค่าเสียงของ bus ที่เลือก
func set_volume(bus_name: String, value: float) -> void:
	var bus_id = AudioServer.get_bus_index(bus_name)
	if bus_id == -1:
		push_warning("Bus '%s' not found!" % bus_name)
		return
	
	AudioServer.set_bus_volume_db(bus_id, value)
	volumes[bus_name] = value  # เก็บไว้ใน dictionary ด้วย

# 📥 ดึงค่าปัจจุบันของ bus
func get_volume(bus_name: String) -> float:
	if volumes.has(bus_name):
		return volumes[bus_name]
	return 0.0
