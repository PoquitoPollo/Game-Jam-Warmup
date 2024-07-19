extends Area3D

#When something enters the deleter's collision
func _on_body_entered(body):
	body.position = Vector3(0,3,0)
