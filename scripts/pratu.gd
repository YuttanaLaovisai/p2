extends StaticBody3D

var is_open = false
@export var red = 90
@export var def = 0
var is_show = false

func interact():
	var target_rotation = def

	if !is_open:
		target_rotation = deg_to_rad(red)
		$open.play()
		is_open = true
		show_label()
	else:
		target_rotation = def
		is_open = false


	var tween = create_tween()
	tween.tween_property(self, "rotation:y", target_rotation, 0.7)

	if !is_open:
		await tween.finished
		$close.play()

func show_label():
	if !is_show:
		$Label.visible = true
		is_show = true
		await get_tree().create_timer(2.5).timeout
		$Label.visible = false
