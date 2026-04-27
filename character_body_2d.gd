extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -800.0

func _ready() -> void:
	create_collision()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func create_collision():
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	var pSize = $PlayerPic.sprite_frames.get_frame_texture(
	$PlayerPic.animation,
	$PlayerPic.frame
	).get_size()

	shape.size = pSize
	collision.shape = shape
	collision.position = $PlayerPic.position
	
	add_child(collision)
