extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var ghostOut = false
var mousePOS
var playerPOS

var lineAngle
var lineLength = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("castout"): #E is the current button for this
		mousePOS = get_global_mouse_position()
		playerPOS = $CollisionShape2D.global_position
		lineAngle = mousePOS.angle_to_point(playerPOS)
		
		#Probably going to be mainly used for debugging but a good starting point
		$Line2D.set_point_position(1, Vector2(-lineLength * cos(lineAngle),-lineLength * sin(lineAngle))) #(sin(lineAngle)/cos(lineAngle)))
		$Player_Blast.position = Vector2(-lineLength * cos(lineAngle),-lineLength * sin(lineAngle))
		#Makes it to where it is not clipping inside of the player on start
		$Player_Blast/CollisionShape2D2.disabled = false
		
	
#func _unhandled_key_input(Input.is_action_pressed("castout")):
