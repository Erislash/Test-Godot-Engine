extends Node

export (PackedScene) var Mob
var score = 0

func _ready():
	randomize()



func gameOver():
	get_tree().call_group("Mob", "queue_free")
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BGMusic.stop()
	$GOSound.play()
	
	
func newGame():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$GOSound.stop()
	$BGMusic.play()


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.offset = randi()
	
	var mob = Mob.instance()
	add_child(mob)
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	mob.linear_velocity = Vector2(rand_range(mob.minSpeed, mob.maxSpeed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

