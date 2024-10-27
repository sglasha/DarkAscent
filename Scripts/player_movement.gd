extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var mousePOS
var playerPOS

var lineAngle
var lineLength = 100

#For when checking if the player can use the blast ability or not
var canBlast = true

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
	
	if (Input.is_action_just_pressed("castout") and canBlast): #E is the current button for this
		mousePOS = get_global_mouse_position()
		playerPOS = $CollisionShape2D.global_position
		lineAngle = mousePOS.angle_to_point(playerPOS)
		canBlast = false
		_player_blast(-lineLength, lineAngle)
		
func _player_blast(lineLeng, lineAng):	
	$Player_Blast.position = Vector2(lineLeng * cos(lineAng),lineLeng * sin(lineAng))
	$Player_Blast/CollisionShape2D2.disabled = false
	$Player_Blast/Sprite2D2.visible = true
	
	#Probably going to be mainly used for debugging but a good starting point
	$Line2D.set_point_position(1, Vector2(lineLeng * cos(lineAng),lineLeng * sin(lineAng)))
	
	#Waits for the timer to expire so the move can reset
	await get_tree().create_timer(1.2).timeout
	$Player_Blast/CollisionShape2D2.disabled = true
	$Player_Blast/Sprite2D2.visible = false
	canBlast = true
	
	$Line2D.set_point_position(1, $Line2D.get_point_position(0))
