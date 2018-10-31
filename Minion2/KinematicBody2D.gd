extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 25
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()
const WORLD1 = "res://World.tscn"
const GAMEOVER = "res://GameOver.tscn"
const GUI = "res://StartMenu.tscn"

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
	print('Daño al enemigo')
	body.hurt()

func _on_VisibilityNotifier2D_screen_exited():
	if get_global_position().y > 512:
		get_tree().change_scene(GUI)
#	var nivel = get_tree().get_nodes_in_group("world")[0]
#	if(nivel.lifes_player<=0):
#		get_tree().change_scene(world1)
#	else:
#	get_tree().change_scene(GUI)
#	pass

func hurt():
	print('me daña el enemigo')
	var nivel = get_tree().get_nodes_in_group("world")[0]
	nivel.delete_life()
	print(nivel.lifes_player)
	if(nivel.lifes_player<=0):
		print("3 daños")
		get_tree().change_scene("res://GameOver.tscn")
	else:
		print("1 daño")
		$Sprite.play("Die")
		#get_tree().change_scene(world)
	
func add_life():
	var nivel = get_tree().get_nodes_in_group("world")[0]
	nivel.add_life()