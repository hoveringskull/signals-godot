class_name AttackAlertLabelEB extends Label

func _ready() -> void:
	RtsEventBus.unit_attacked.connect(on_attacked)
	hide()

func on_attacked(_unit: RtsUnitEB) -> void:
	show()