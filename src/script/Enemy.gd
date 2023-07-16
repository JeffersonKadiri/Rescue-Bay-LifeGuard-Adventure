extends KinematicBody2D

signal HitPlayer

onready var view_port: = get_viewport_rect()

export var speed: = 200

onready var enemy_sprite: = get_node("Sprite")

var velocity: = Vector2.ZERO
var Enemie_width_half
const Enemies_Texture : Array = ["res://asset/Sprite/crocodile.png", "res://asset/Sprite/Shark.png"]

func _ready():
	randomize()
	load_enemy()
	Enemie_width_half= $Sprite.texture.get_width()
	velocity.x = speed

func load_enemy() -> void:
	var random_index = randi() % Enemies_Texture.size()
	var texture_resource = load(Enemies_Texture[random_index]) 
	enemy_sprite.set_texture(texture_resource)

func _physics_process(delta):
	changeDirection()
	var collision = move_and_collide(velocity * delta)
	if collision:
		var colliding_object = collision.collider
		colliding_object.queue_free()
		emit_signal("HitPlayer")

func changeDirection():
	if position.x < view_port.position.x - Enemie_width_half or position.x > view_port.size.x + Enemie_width_half:
		enemy_sprite.flip_h = not enemy_sprite.is_flipped_h() 
		velocity.x = -velocity.x
