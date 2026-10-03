extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = [
		"You died. Wow.",
		"Don't hug \n the asteroids.",
		"Why?",
		"Remember to \n breathe, mate.",
		"Haha, very funny, \n now actually try.",
		"Maybe try breathing \n next time.",
		"Ouch, and I \ndidn't think \nyour self esteem \ncould get any lower",
		"Nice try... \nfor a noob!"
	].pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
