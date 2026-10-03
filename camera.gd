extends Camera2D
var rng = RandomNumberGenerator.new()
var SHAKE_STRENGTH: float = 0

@export var rand_strength: float = 30.0
@export var fade: float = 5.0


func shake():
	SHAKE_STRENGTH = rand_strength



func trandomize() -> Vector2:
	return Vector2(rng.randf_range(-SHAKE_STRENGTH, SHAKE_STRENGTH),rng.randf_range(-SHAKE_STRENGTH, SHAKE_STRENGTH))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if SHAKE_STRENGTH > 0:
		SHAKE_STRENGTH = lerpf(SHAKE_STRENGTH,0,fade * delta)
		offset = trandomize()
