extends Sprite2D

func _process(_delta: float) -> void:
	rotate(get_angle_to($"../../StaticBody2D".position)+deg_to_rad(90))
