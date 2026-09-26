extends Area2D

const SPEED = 20.0
var direction = -1.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

# Will run in every frame	
func _process(delta: float) -> void:
	position.x += SPEED * direction * delta

# Will run every Ns 	
func _on_timer_timeout() -> void:
	direction *=-1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


func _on_player_entered(body: Node2D) -> void:
	if body.name == 'Player':
		SignalHub.emit_player_died(body)
