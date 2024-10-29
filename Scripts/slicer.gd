extends Node2D

const speed = 100
var direction = -1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var playerCheckLeft: RayCast2D = $PlayerCheckLeft
@onready var playerCheckRight: RayCast2D = $PlayerCheckRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == -1 and playerCheckLeft.is_colliding():
		animated_sprite.animation = "RunCycle"
	if direction == 1 and playerCheckRight.is_colliding():
		animated_sprite.animation = "RunCycle"
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
		animated_sprite.animation = "WalkCycle"
	if ray_cast_left.is_colliding():
		direction = +1
		animated_sprite.flip_h = true
		animated_sprite.animation = "WalkCycle"
	
	if animated_sprite.animation == "WalkCycle":
		position.x += direction * speed * delta
	if animated_sprite.animation == "RunCycle":
		position.x += direction * speed * delta * 2
