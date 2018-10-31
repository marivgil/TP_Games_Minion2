extends StaticBody2D

var flip = true
var initial_position
var final_position
var velocity = 0.3
var lifes = 2

func _ready():
	$AnimatedSprite.play("Idle")
	initial_position = $".".position.x
	final_position = initial_position + 50
	
func _process(delta):
	if(initial_position <= final_position and flip):
		position.x += velocity
		$AnimatedSprite.flip_h = true
		if(position.x >= final_position):
			flip = false
			
	if(position.x >= initial_position and !flip):
		position.x -= velocity
		$AnimatedSprite.flip_h = false
		if(position.x <= initial_position):
			flip = true
			
func hurt():
	if(lifes==1):
		queue_free()
	elif(lifes==2):
		$AnimatedSprite.play("gotHit")
		velocity += 1
		lifes -= 1


func _on_Area2D_body_entered(body):
	print('daño al player')
	if body.is_in_group("Player"):
		print('dentro del if')
		body.hurt()
