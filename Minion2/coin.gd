extends StaticBody2D

func _on_Area2D_body_entered(body):
	queue_free()
	body.add_life()
	pass