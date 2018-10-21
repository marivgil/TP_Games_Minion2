extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 25
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()
var main = "res://Main.tscn"
var world = "res://World.tscn"

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x, 0, 0.1)
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.15)
	else:
		$Sprite.play("Jump")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)

	motion = move_and_slide(motion, UP)
	pass


func _on_Node2D_body_entered(body):
	body.hurt()


func _on_VisibilityNotifier2D_screen_exited():
	var nivel = get_tree().get_nodes_in_group("main")[0]
	if(nivel.lifes_player<=0):
		get_tree().change_scene("res://StartMenu.tscn")
	else:
		get_tree().change_scene(main)

func hurt():
	var nivel = get_tree().get_nodes_in_group("main")[0]
	print(nivel.lifes_player)
	nivel.delete_life()
	print(nivel.lifes_player)
	print("daño en el player")
	if(nivel.lifes_player<=0):
		print("vidas menor a cero")
		get_tree().change_scene("res://StartMenu.tscn")
	else:
		print("vidas mayor a cero")
		$Sprite.play("Die")
		#get_tree().change_scene(world)
	pass