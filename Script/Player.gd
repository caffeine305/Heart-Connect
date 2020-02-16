extends KinematicBody

var velocity = Vector3(0,0,0)
const SPEED = 6

func _ready(): #kinda like the Unity
	pass #ends function
	
func _physics_process(delta): #This is the FixedUpdate from Unity, Godot version
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = lerp(velocity.x,0,0.1)

	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_up"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_down"):
		velocity.z = SPEED
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
	else:
		velocity.z = lerp(velocity.z,0,0.1)
	move_and_slide(velocity)
