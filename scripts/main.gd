extends Node3D

@onready var player = $player
#@export var 

func _ready() -> void:
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

func _process(delta: float) -> void:
	if player.position.y < -20:
		player.position = Vector3(0, 10, 0)
