extends KinematicBody2D


onready var screen_size: = get_viewport_rect().size

export (int) var speed: = 200

var velocity: = Vector2.ZERO

func _physics_process(_delta):
	InputandAnimate()
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 137, $Camera2D.limit_bottom)
	move_and_slide(velocity * speed)

func startPositioning(pos) -> void:
	position = pos

func InputandAnimate() -> void:
	movePlayer()
	Animate()

func Animate() -> void:
	rest_animation()
	swim_animation()

func swim_animation() -> void:
	if IsKeyPressed("move_up"):
		$AnimatedSprite.play("swim_up")
	if IsKeyPressed("move_left"):
		$AnimatedSprite.play("swim_left")
	if IsKeyPressed("move_right"):
		$AnimatedSprite.play("swim_right")
	if IsKeyPressed("move_down"):
		$AnimatedSprite.play("swim_down")
	swimKeyCombination()

func swimKeyCombination() -> void:
	if IsKeyPressed("move_up") and IsKeyPressed("move_left"):
		$AnimatedSprite.play("swim_up_left")

	if IsKeyPressed("move_down") and IsKeyPressed("move_left"):
			$AnimatedSprite.play("swim_down_left")

	if IsKeyPressed("move_up") and IsKeyPressed("move_right"):
		$AnimatedSprite.play("swim_up_right")

	if IsKeyPressed("move_down") and IsKeyPressed("move_right"):
		$AnimatedSprite.play("swim_down_right")

func rest_animation() -> void:
	if IsKeyReleased("move_left"):
		$AnimatedSprite.play("rest_left")
	if IsKeyReleased("move_right"):
		$AnimatedSprite.play("rest_right")
	if IsKeyReleased("move_down"):
		$AnimatedSprite.play("rest_down")
	if IsKeyReleased("move_up"):
		$AnimatedSprite.play("rest_up")
	RestKeyCombination()

func RestKeyCombination():
	if IsKeyReleased("move_left") and IsKeyReleased("move_up"):
		$AnimatedSprite.play("rest_up_left")
	if IsKeyReleased("move_down") and IsKeyReleased("move_left"):
		$AnimatedSprite.play("rest_down_left")
	if IsKeyReleased("move_right") and IsKeyReleased("move_up"):
		$AnimatedSprite.play("rest_up_right")
	if IsKeyReleased("move_down") and  IsKeyReleased("move_right"):
		$AnimatedSprite.play("rest_down_right")

func movePlayer() -> void:
	velocity = Vector2.ZERO
	
	if IsKeyPressed("move_left"):
		velocity.x -= 1
	if IsKeyPressed("move_right"):
		velocity.x += 1
	if IsKeyPressed("move_down"):
		velocity.y += 1
	if IsKeyPressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized()
		$SwimSound.play()

func IsKeyPressed(dir: String) -> bool:
	return Input.is_action_pressed(dir)

func IsKeyReleased(dir: String) -> bool:
	return Input.is_action_just_released(dir)

func IsKeyJustPressed(dir: String) -> bool:
	return Input.is_action_just_pressed(dir)
