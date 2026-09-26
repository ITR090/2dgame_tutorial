extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collected_sound: AudioStreamPlayer2D = $CollectedSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


# when player hits the apple
func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		# 1. Turn off the collision so it can't be triggered again
		collision_shape_2d.set_deferred("disabled",true)
		# 2. Play the sound and animation
		animated_sprite_2d.play('collected')
		collected_sound.play()
		SignalHub.emit_apple_collected()	
		# 3. Wait for the animation to finish
		if animated_sprite_2d.animation == "collected":
			await animated_sprite_2d.animation_finished	
			await collected_sound.finished
			# 4. Safely delete the apple
			queue_free()		
		
