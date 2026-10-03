extends CharacterBody2D
var speed: float
var dir: Vector2
var TIMER = 2000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.frame = randi_range(0,3)
	
	speed = randi_range(100, 500)
	position = Vector2(randi_range(-3000, 3000),-1000)
	if position.x < 0:
		rotation_degrees = randi_range(45, 90)
	else:
		rotation_degrees = randi_range(90, 135)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if TIMER == 0:
		get_parent().queue_free()
	else:
		TIMER -= 1
	dir = Vector2.from_angle(rotation)
	velocity = dir * speed
	$Sprite2D.rotate(deg_to_rad(speed/70))
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get("oxygen"):
		get_tree().change_scene_to_file("res://gameover.tscn")
