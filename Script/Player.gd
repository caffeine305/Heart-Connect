extends KinematicBody

var velocity = Vector3(0,0,0)
var direction = Vector3(0,0,0)
var character
var camera

var char_rot
var angle

const SPEED = 10
const ACCEL = 5
const DE_ACCEL = 7
const GRAVITY = -9.8

func _ready(): #pretty much like Unity's Start() function
	#camera = get_node(" ") #<-- Averiguar a qué debería apuntar.
	character = get_node(".")
	char_rot = character.get_rotation()
		#pass #ends function
	
func _physics_process(delta): #This is the FixedUpdate from Unity, Godot version
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		direction.x = 0
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
	elif Input.is_action_just_released("ui_right"):
		direction.x = 0
		
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1	
	elif Input.is_action_just_released("ui_left"):
		direction.x = 0
	#else:
	#	direction.x = lerp(direction.x,0,0.1)
		
		
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_up"):
		direction.z = 0
	elif Input.is_action_pressed("ui_down"):
		direction.z = 1
	elif Input.is_action_just_released("ui_down"):
		direction.z = 0

	elif Input.is_action_pressed("ui_up"):
		direction.z = -1
		
	elif Input.is_action_just_released("ui_up"):
		direction.z = 0
	#else:
	#	direction.z = lerp(direction.z,0,0.1)
	
		
	direction.y = 0
	direction = direction.normalized()
	
	velocity.y = delta * GRAVITY 
	
	var dv = velocity
	dv.y = 0
	
	var dx = direction * SPEED
	
	var accel = DE_ACCEL
	if (direction.dot(dv) > 0):
		accel = ACCEL
		angle = atan2(direction.x,direction.z)
	#línea 44: el personaje rota "tieso"
		char_rot.y = angle
	#línea 45: el personaje rota "suave"
	#char_rot.y = lerp(char_rot.y,angle,0.1)
		character.set_rotation(char_rot)
	
	dv = dv.linear_interpolate(dx, accel*delta)
	
	velocity.x = dv.x
	velocity.z = dv.z

	velocity = move_and_slide(velocity,Vector3(0,1,0))
	
	print(direction)
