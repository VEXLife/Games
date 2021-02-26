extends KinematicBody2D


signal die

const ACCELERATION = 500
const MAX_SPEED=80
const ROLL_SPEED=120
const FRICTION=500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity=Vector2.ZERO
var roll_vector = Vector2.RIGHT

func _ready():
	$AnimationTree.active = true
	PlayerStats.connect("no_health", self, "player_die")

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			roll_state()
			
		ATTACK:
			attack_state()

func move_state(delta):
	var input_vector=Vector2.ZERO
	input_vector.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y=Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector=input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector=input_vector
		
		if Input.is_action_pressed("ui_up"):
			$HitBoxPivot/SwordHitBox.look_dir = Vector2.UP
		elif Input.is_action_pressed("ui_down"):
			$HitBoxPivot/SwordHitBox.look_dir = Vector2.DOWN
		elif Input.is_action_pressed("ui_right"):
			$HitBoxPivot/SwordHitBox.look_dir = Vector2.RIGHT
		elif Input.is_action_pressed("ui_left"):
			$HitBoxPivot/SwordHitBox.look_dir = Vector2.LEFT
		
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Run/blend_position", velocity)
		$AnimationTree.set("parameters/Attack/blend_position", velocity)
		$AnimationTree.set("parameters/Roll/blend_position", velocity)
		$AnimationTree.get("parameters/playback").travel("Run")
		velocity=velocity.move_toward(input_vector*MAX_SPEED,ACCELERATION*delta)
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
		velocity=velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	
	do_move()
	
	if Input.is_action_just_pressed("ui_roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("ui_attack"):
		state=ATTACK

func roll_state():
	velocity=roll_vector * ROLL_SPEED
	$AnimationTree.get("parameters/playback").travel("Roll")
	do_move()

func attack_state():
	velocity = Vector2.ZERO
	$AnimationTree.get("parameters/playback").travel("Attack")

func do_move():
	velocity=move_and_slide(velocity)

func _on_attack_finished():
	state = MOVE

func _on_roll_finished():
	velocity=Vector2.ZERO
	state=MOVE

func player_die():
	emit_signal("die")
	queue_free()
