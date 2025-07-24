extends CharacterBody2D
class_name PlayerController


@export var speed = 10.0
@export var jump_power = 15.0
@export var camera : Camera2D

var speed_mult = 10.0
var jump_mult = -20.0
var direction = 0

func _input(event):
	# Handle jump.
	if event.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jump_power * jump_mult
	
	#Handle jump down
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_Right")
	if direction:
		velocity.x = direction * speed * speed_mult
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_mult)

	move_and_slide()
	
func teleport_to_location(new_location):
	camera.position_smoothing_enabled = false
	await get_tree().physics_frame
	position = new_location
	camera.position_smoothing_enabled = true
