extends KinematicBody2D

const BatDeath = preload("res://Effects/BatDeath.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

export (int) var ACCELERATION = 300
export (int) var MAX_SPEED = 50
export (int) var FRICTION = 200

var state = CHASE
var knockback=Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	$Sprite.playing = true

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		
		WANDER:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if global_position.distance_to($WanderController.destination) > 3:
				velocity = velocity.move_toward(global_position.direction_to($WanderController.destination).normalized() * MAX_SPEED, ACCELERATION * delta)
			seek_player()
		
		CHASE:
			if $PlayerDetectionZone.can_see_player():
				velocity = velocity.move_toward(global_position.direction_to($PlayerDetectionZone.player.global_position).normalized() * MAX_SPEED, ACCELERATION * delta)
			else:
				$StateSwitcher.start()
				_on_StateSwitcher_timeout()
	
	$Sprite.flip_h = velocity.x < 0
	velocity=move_and_slide(velocity)			

func seek_player():
	if $PlayerDetectionZone.can_see_player():
		$StateSwitcher.stop()
		state = CHASE

func _on_be_attacked(area):
	var hitEffect = get_tree().current_scene.HitEffect.instance()
	get_tree().current_scene.add_child(hitEffect)
	hitEffect.global_position = global_position + Vector2(0, -13)
	$Stats.health -= area.damage
	knockback = area.look_dir * 120


func _on_Stats_no_health():
	var batDeath = BatDeath.instance()
	get_parent().add_child(batDeath)
	batDeath.global_position = global_position
	queue_free()


func _on_HitBox_area_entered(area):
	_on_AttackTimer_timeout()
	$AttackTimer.start()

func _on_AttackTimer_timeout():
	var hitEffect = get_tree().current_scene.HitEffect.instance()
	get_tree().current_scene.add_child(hitEffect)
	hitEffect.global_position = global_position + Vector2(0, -9)
	PlayerStats.health -= $HitBox.damage


func _on_HitBox_area_exited(area):
	$AttackTimer.stop()

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_StateSwitcher_timeout():
	state = pick_random_state([IDLE, WANDER])
	$StateSwitcher.wait_time = rand_range(1, 3)
	if state == WANDER:
		$WanderController.destination = $WanderController.source + Vector2(rand_range(-1,1),rand_range(-1,1)).normalized() * $WanderController.wander_radius
