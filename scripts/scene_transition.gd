extends CanvasLayer

func chang_scene(target : String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")

func play_anim() -> void:
	$AnimationPlayer.play_backwards("dissolve")
