extends Node3D

@onready var leftSprite = get_node("Left")
@onready var rightSprite = get_node("Right")
@onready var frontSprite = get_node("Front")
@onready var backSprite = get_node("Back")
#@onready var camera : Camera3D = get_tree().get_first_node_in_group("Player/Camroot/SpringArm3d/Camera3D")
@onready var camera = get_node("/root/World/Player/Camroot/SpringArm3D/Camera3D")

var leftPoint
var rightPoint
var backPoint
var frontPoint
var cameraPoint

var leftDistance
var rightDistance
var backDistance
var frontDistance

var currentAnimation

var isWalking

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	leftPoint = leftSprite.get_global_position()
	rightPoint = rightSprite.get_global_position()
	frontPoint = frontSprite.get_global_position()
	backPoint = backSprite.get_global_position()

	cameraPoint = camera.get_global_position()

	leftDistance = cameraPoint.distance_to(leftPoint)
	rightDistance = cameraPoint.distance_to(rightPoint)
	backDistance = cameraPoint.distance_to(backPoint)
	frontDistance = cameraPoint.distance_to(frontPoint)
	
	backSprite.hide()
	frontSprite.hide()
	leftSprite.hide()
	rightSprite.hide()

	#find and display correct sprite based on distance (note right/left sprite are further in
	#thus giving them less of a viewing angle
	if (backDistance<leftDistance && backDistance<rightDistance && backDistance<frontDistance):
		backSprite.show()
	elif (frontDistance<leftDistance && frontDistance<rightDistance):
		frontSprite.show()
	elif (rightDistance<leftDistance):
		rightSprite.show()
	else : 
		leftSprite.show()


	if (isWalking == true):
		currentAnimation = "run"
	else:
		currentAnimation = "idle"

	#play correct animation on all character sprites
	backSprite.play(currentAnimation)
	leftSprite.play(currentAnimation)
	rightSprite.play(currentAnimation)
	frontSprite.play(currentAnimation)

#an example of a call, used by a script higher up in the tree to update this script
func walking(toggle) :
	if (toggle == true):
		isWalking = true
	else :
		isWalking = false
