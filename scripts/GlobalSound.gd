extends Node

@onready var player = AudioStreamPlayer.new()

func _ready():
	add_child(player)

func play_sound(path: String):
	player.stream = load(path)
	player.play()
