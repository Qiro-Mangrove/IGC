extends Node2D
var ASTEROID: PackedScene = preload("res://asteroid.tscn")
var DEBRIS: PackedScene = preload("res://debris.tscn")
var TIMER = 0
var TIMER2 = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if TIMER == 0:
		var debris = DEBRIS.instantiate()
		debris.position = Vector2(0,-1000)
		add_child(debris)
		TIMER = randi_range(20, 400)
	else:
		TIMER -= 1

	if TIMER2 == 0:
		var asteroid = ASTEROID.instantiate()
		asteroid.position = Vector2(0,-1000)
		add_child(asteroid)
		TIMER2 = randi_range(10, 200)
	else:
		TIMER2 -= 1
