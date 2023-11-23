extends Area2D
signal hit
@export var speed = 400
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	# 获取屏幕尺寸
	screen_size = get_viewport_rect().size
	# 在游戏开始时隐藏玩家
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	# 默认情况下玩家不移动，移动的向量
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	# 加上动画
	if velocity.x != 0 :
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		


func _on_body_entered(body):
	# 开始新游戏时重置玩家
	hide()
	hit.emit()
	# set_deferred() 禁止禁用区域碰撞
	$CollisionShape2D.set_deferred("disabled", true)
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
