extends CharacterBody3D

const SPEED = 8.0
const JUMP_VELOCITY = 12.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 24

@onready var camroot = $Camroot
@onready var mesh = $Positions

func _ready():
#makes it so you don't need to click on the screen to use mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	#inputs are defined in Project->Project Settings->Input Map
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#rotates character controller to follow y of camera
	direction = direction.rotated(Vector3.UP,camroot.rotation.y).normalized()
	
	if direction:
		#rotates rendered character so they're pointing based on player input
		#pi/2 added because input_dir works on an x/y 2d plane that's 90 deg off from x/z 3d plane
		#similarly, 3d plane I think rotates differently, thus the negatives
		mesh.rotation.y = -(input_dir.angle()+(PI/2)-camroot.rotation.y)
		
		#letting positions know that player is moving
		mesh.walking(true)
		
		#moves character smoothly based on direction(s) input
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		#letting positions know that player is no longer moving
		mesh.walking(false)
		
		velocity.x = 0
		velocity.z = 0
	
	#to prevent sticking to terrain
	move_and_slide()
