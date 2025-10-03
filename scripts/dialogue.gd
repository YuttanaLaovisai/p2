extends CanvasLayer

@onready var dialogue_label = $DialogueLabel
@export var lines = [
	"\"Damn it... Why did the car have to break down now?\"",
	"\"And I don’t even have any spare parts...\"",
	"\"Guess I’ll have to search the abandoned houses around here...\""
]

var index = 0

func _ready():
	await get_tree().create_timer(1.5).timeout
	$DialogueLabel.visible = true
	await play_dialogue()
	Globalkey.is_on = true

func play_dialogue():
	for line in lines:
		dialogue_label.text = line
		await get_tree().create_timer(4).timeout  # อยู่ 2.5 วิ ต่อบรรทัด
	dialogue_label.visible = false
