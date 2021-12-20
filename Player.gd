extends Area2D

signal hit

export var speed = 400		# Using "export" keyword will show the varibale in the inspector
var screenSize



func _ready():
	screenSize = get_viewport_rect().size
	hide()



func _process(delta):
	var velocity: Vector2 = Vector2()
	
	# =================== Movement ===================
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		

	# =================== Restricted Movement ===================
	position += velocity * delta
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	
	
	# =================== Animation ===================
	if velocity.x != 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_h = velocity.x < 0
		
	elif velocity.y != 0:
		$AnimatedSprite.animation = 'up'
		$AnimatedSprite.flip_v = velocity.y > 0



func _on_Player_body_entered(body):
	hide()	# The player will disappear after being hitted
	emit_signal("hit")
	$CollisionShape2D.set_deferred('disabled', true)



func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false







