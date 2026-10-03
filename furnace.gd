extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get("TRASH_COLLECTED"):
		body.FUEL += body.TRASH_COLLECTED * 1000
		body.TRASH_COLLECTED -= body.TRASH_COLLECTED
		$AnimatedSprite2D.visible = true
		$AudioStreamPlayer.play()
		await get_tree().create_timer(0.75).timeout
		$AnimatedSprite2D.visible = false

func _process(_delta: float) -> void:
	$AnimatedSprite2D.play("default")
