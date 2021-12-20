extends RigidBody2D

export var minSpeed = 150
export var maxSpeed = 250


func _ready():
	var mobTypes = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mobTypes[randi() % mobTypes.size()]
	



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
