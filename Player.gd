extends CharacterBody2D
var Speed = 6
var in_ship = true
var oxygen = 1000
var TRASH_COLLECTED = 0
var FUEL = 1000
var FuelMusicOn = false
var GONE = false
var ENDING_SCENE = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"../TextureRect".position.y += 1
	if in_ship == false:
		if Input.is_action_pressed("Forward"):
			velocity.y -= Speed
			if $SpacemanSprite.frame == 0:
				$SpacemanSprite.frame = 2
			if $SpacemanSprite.frame == 1:
				$SpacemanSprite.frame = 3
		if Input.is_action_pressed("Back"):
			velocity.y += Speed
			if $SpacemanSprite.frame == 2:
				$SpacemanSprite.frame = 0
			if $SpacemanSprite.frame == 3:
				$SpacemanSprite.frame = 1
		if Input.is_action_pressed("Left"):
			velocity.x -= Speed
			if $SpacemanSprite.frame < 2:
				$SpacemanSprite.frame = 0
			else:
				$SpacemanSprite.frame = 2
		if Input.is_action_pressed("Right"):
			velocity.x += Speed
			if $SpacemanSprite.frame < 2:
				$SpacemanSprite.frame = 1
			else:
				$SpacemanSprite.frame = 3
		oxygen -= 0.5
		velocity /= 1.02
		if oxygen < 400:
			$"../MainMusic".volume_db -= 0.1
		if oxygen == 300:
			$"../LowOxygenMusic".volume_db = 0
			$"../LowOxygenMusic".play()
		if $Camera2D.zoom > Vector2(0.5,0.5) and ENDING_SCENE == false:
			$Camera2D.zoom -= Vector2(0.01,0.01)
	else:
		if Input.is_action_pressed("Forward"):
			velocity.y = Speed * -100
			if $SpacemanSprite.frame == 0:
				$SpacemanSprite.frame = 2
			if $SpacemanSprite.frame == 1:
				$SpacemanSprite.frame = 3
		elif Input.is_action_pressed("Back"):
			velocity.y = Speed * 100
			if $SpacemanSprite.frame == 2:
				$SpacemanSprite.frame = 0
			if $SpacemanSprite.frame == 3:
				$SpacemanSprite.frame = 1
		else:
			velocity.y = 0
		if Input.is_action_pressed("Left"):
			velocity.x = Speed * -100
			if $SpacemanSprite.frame < 2:
				$SpacemanSprite.frame = 0
			else:
				$SpacemanSprite.frame = 2
		elif Input.is_action_pressed("Right"):
			velocity.x = Speed * 100
			if $SpacemanSprite.frame < 2:
				$SpacemanSprite.frame = 1
			else:
				$SpacemanSprite.frame = 3
		else:
			velocity.x = 0
		if oxygen < 1000:
			oxygen += 5
		$"../LowOxygenMusic".volume_db -= 0.5
		if $"../MainMusic".volume_db < 0:
			$"../MainMusic".volume_db += 1
		if $Camera2D.zoom < Vector2(1,1) and ENDING_SCENE == false:
			$Camera2D.zoom += Vector2(0.01,0.01)
	$Camera2D/CanvasLayer/Oxygen.value = oxygen
	if oxygen < 300:
		$Camera2D.shake()
	if FUEL < 500:
		$Camera2D.shake()
	if oxygen == 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
	if FUEL == 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
	$Camera2D/CanvasLayer/Scrap.value = TRASH_COLLECTED
	$Camera2D/CanvasLayer/Power.value = FUEL
	if FUEL < 500 and FUEL > 499.98:
		$"../MainMusic".volume_db = -100
		$"../LowPowerMusic".play()
		FuelMusicOn = true
	if FuelMusicOn == true and FUEL > 500:
		$"../MainMusic".volume_db = 0
		$"../LowPowerMusic".stop()
	if FUEL > 9999:
		if GONE == false:
			$"../StuffSpawner".queue_free()
			GONE = true
			$"../StaticBody2D/Sprite2D2".visible = true
			$"../StaticBody2D/Sprite2D3".visible = true
			ENDING_SCENE = true
			$"../AudioStreamPlayer".play()
		if $Camera2D.zoom > Vector2(0.25,0.25):
			$Camera2D.zoom -= Vector2(0.0029,0.0029)
			$Camera2D.shake()
		else:
			$Camera2D.shake()
			$Camera2D.rand_strength += 2
			$"../StaticBody2D/Sprite2D".frame = 1
			visible = false
			$"../Furnace".visible = false
			$"../TextureRect".position.y += 100
			await get_tree().create_timer(10).timeout
			get_tree().change_scene_to_file("res://winning_screen.tscn")
	else:
		FUEL -= 0.3
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get("in_ship") == false:
		in_ship = true
		$Sprite2D2.visible = false
		$"../Furnace".visible = true
		$Camera2D/CanvasLayer/Oxygen.visible = false
		$Camera2D/CanvasLayer/Power.visible = true
		if $"../LowOxygenMusic".playing == true:
			$"../LowOxygenMusic".volume_db -= 0.5
			$"../MainMusic".volume_db = -100
			$"../MainMusic".play()
		$"../StaticBody2D/Sprite2D".frame = 0


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.get("in_ship"):
		in_ship = false
		velocity = Vector2(0,0)
		$"../Furnace".visible = false
		$Camera2D/CanvasLayer/Oxygen.visible = true
		$Camera2D/CanvasLayer/Power.visible = false
		$Sprite2D2.visible = true
		$"../StaticBody2D/Sprite2D".frame = 1
