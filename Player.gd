extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed : int = 200
var jumpForce : int = 450
var gravity : int = 800
var vel : Vector2 = Vector2()
var grounded : bool = false
var motion : Vector2 = Vector2()
var motion_previous : Vector2 = Vector2()

onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel.x = 0
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
	vel = move_and_slide(vel, Vector2.UP)
	vel.y += gravity * delta
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
		
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false

	if not is_on_floor():
		grounded = false
		$Sprite.scale.y = range_lerp(abs(motion.y), 0, abs(jumpForce), 0.75, 1.75)
		$Sprite.scale.x = range_lerp(abs(motion.y), 0, abs(jumpForce), 1.25, 0.75)

	if not grounded and is_on_floor():
		grounded = true
		$Sprite.scale.x = range_lerp(abs(motion_previous.y), 0, abs(1700), 1.2, 2)
		$Sprite.scale.y = range_lerp(abs(motion_previous.y), 0, abs(1700), 0.8, 0.5)
		
	$Sprite.scale.x = lerp($Sprite.scale.x, 1, 1 - pow(0.01, delta))
	$Sprite.scale.y = lerp($Sprite.scale.y, 1, 1 - pow(0.01, delta))	
