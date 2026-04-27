extends CharacterBody2D

const time_in_timer = 0.7
var move_up_released = false
var fly_time = 0
const max_fly_time = 35
const SPEED = 600.0
const JUMP_VELOCITY = -300.0
var timer_started = false

func _ready() -> void:
	create_collision()
	$Timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout():
	print("timeout")
	$Timer.stop()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("move_up") and not move_up_released and (is_on_floor() or $Timer.time_left > 0):
		velocity.y = JUMP_VELOCITY 
		#print($Timer.time_left)
	
	if Input.is_action_just_released("move_up") and not is_on_floor():
		move_up_released = true
	
	if not is_on_floor() and not timer_started:
		print("Timer started")
		timer_started = true
		$Timer.start(time_in_timer)
	
	if is_on_floor():
		timer_started = false
		move_up_released = false
		$Timer.stop()
		

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
