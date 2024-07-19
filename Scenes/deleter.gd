extends Area3D

#When something enters the deleter's collision
func _on_body_entered(body):
	if body.is_in_group("Enemies") :
		#delete it!
		body.queue_free()
