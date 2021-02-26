extends KinematicBody2D


export (int) var SPEED = 100
export (int) var JUMP_SPEED = 200
export (int) var GRAVITY = 300
var velocity = Vector2.ZERO
enum STATES {
	IDLE,
	JUMP,
	RUN,
	ATTACK,
	DIE
}
var State

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("die",self,"on_die")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match State:
		STATES.DIE:
			$AnimationTree.get("parameters/playback").travel("Die")
			return
		STATES.IDLE:
			$AnimationTree.get("parameters/playback").travel("Idle")
		STATES.RUN:
			$AnimationTree.get("parameters/playback").travel("Run")
		STATES.ATTACK:
			velocity.x = 0
			$AnimationTree.get("parameters/playback").travel("Swipe")
	
	if is_on_ceiling():
		velocity.y = 0
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = -JUMP_SPEED
	else:
		velocity.y += delta * GRAVITY

	if State != STATES.ATTACK:
		if Input.is_action_just_pressed("ui_attack"):
			State = STATES.ATTACK
		elif Input.is_action_pressed("ui_left"):
			velocity.x = - SPEED
			$Sprite.flip_h = true
			$PlayerHitBox/CollisionShape2D.position.x = -abs($PlayerHitBox/CollisionShape2D.position.x)
			State = STATES.RUN
		elif Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			$Sprite.flip_h = false
			$PlayerHitBox/CollisionShape2D.position.x = abs($PlayerHitBox/CollisionShape2D.position.x)
			State = STATES.RUN
		else:
			velocity.x = 0
			State = STATES.IDLE
	

	move_and_slide(velocity, Vector2(0, -1))

func attack_finished():
	State = STATES.IDLE
	
func on_die():
	State = STATES.DIE

func hurt_anim():
	$Sprite.modulate = Color(5,5,5)
	yield(get_tree().create_timer(0.3),"timeout")
	$Sprite.modulate = Color(1,1,1)
