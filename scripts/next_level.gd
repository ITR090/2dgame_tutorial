extends Area2D

const FILE_PATH = "res://scenes/levels/level_"
const FINAL_PATH = "res://scenes/levels/level_4.tscn"
@onready var color_rect: ColorRect = $transition_screen/ColorRect
@onready var animation_player: AnimationPlayer = $transition_screen/AnimationPlayer

	
func transition() -> void:
	color_rect.visible =true
	animation_player.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	color_rect.visible = false
	animation_player.play("fade_to_normal")
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await transition()
		var current_scene_file= get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int()  +1
		var next_level_path = FILE_PATH + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
		if next_level_path == FINAL_PATH:
			get_tree().change_scene_to_file("res://scenes/UI/end.tscn")
	
		
		
		
