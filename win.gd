extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3).timeout
	text = "You made it \n to safety..."
	await get_tree().create_timer(3).timeout
	text = "Good job, cadet."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
