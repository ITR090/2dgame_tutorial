extends CharacterBody2D

var is_alive = true
const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound


func _ready() -> void:
	SignalHub.player_died.connect(die)
	SignalHub.collected.connect(point_collected)

func _physics_process(delta: float) -> void:
	
	if !is_alive:
		return
		
	# Add the gravity Jump
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.play("jump")
		
	# Runing
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.play("Run")	
	else:
		animated_sprite_2d.play("idle")	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#	flip direction	
	if direction == 1.0:
		animated_sprite_2d.flip_h= false
	if direction == -1.0:
		animated_sprite_2d.flip_h=true
			
	move_and_slide()

func die(player) -> void:
	is_alive = false
	animated_sprite_2d.play("Hit")
	death_sound.play()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/UI/end.tscn") 
	
func point_collected() -> void:
	ScoreManger.increase_socre()
