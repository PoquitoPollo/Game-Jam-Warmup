extends CharacterBody3D

@export var stationary = false
@export var SPEED = 8.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 24

@onready var mesh = $Positions

func _ready():
	add_to_group("Enemies")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the direction and handle the movement/deceleration
	#In this example enemy always moves forward
	var input_dir = Vector2(1,0)	#can only move along 2d plane
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if (stationary):
		direction = Vector3(0,0,0)
	
	if direction:
		#rotates rendered character so they're pointing based on current movement
		#pi/2 added because input_dir works on an x/y 2d plane that's 90 deg off from x/z 3d plane
		mesh.rotation.y = -(input_dir.angle()+(PI/2))
		
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
