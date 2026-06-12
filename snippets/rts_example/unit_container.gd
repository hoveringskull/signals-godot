class_name UnitContainer

signal unit_health_changed(unit)

var units: Array[Unit]

func add_unit() -> void:
	var unit = Unit.new()
	unit.health_changed.connect(on_health_changed)
	units.append(unit)

func on_unit_health_changed(unit: Unit) -> void:
	print("Health changed; passing signal up the hierarchy")
	unit_health_changed.emit(unit)