class_name UnitsLeftLabel extends Label

signal update(units_left: int)

func _ready() -> void:
	update.connect(on_update)

func on_update(units_left: int) -> void:
	text = "Units Left: " + str(units_left)