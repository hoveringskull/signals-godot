class_name UnitContainer extends Node

signal unit_selected(unit: RtsUnit)
signal unit_count_changed(count: int)
signal attacked()
signal all_player_units_died()

var units: Array[RtsUnit] = []

var _selected_unit: RtsUnit
var selected_unit: RtsUnit:
	get: return _selected_unit
	set(value):
		if value == _selected_unit:
			return

		if _selected_unit:
			_selected_unit.on_deselect()
			unit_selected.emit(null)

		_selected_unit = value
		if _selected_unit:
			_selected_unit.on_select()
			unit_selected.emit(_selected_unit)

var player_unit_count: int:
	get: return units.filter(func(list_unit: RtsUnit) -> bool: return list_unit.unit_name == "Bunny Marine").size()

func add_unit(scene: PackedScene, spawn_position: Vector2) -> void:
	var unit: RtsUnit = scene.instantiate() as RtsUnit
	add_child(unit)
	units.append(unit)
	unit.position = spawn_position

	# Call down signal up: we're connecting these signals here so that unit can trigger stuff in this script without knowing about it!
	unit.clicked.connect(func(clicked_unit: RtsUnit) -> void: self.selected_unit = clicked_unit)

	# Broadcast to various places from a single event
	unit.died.connect(on_unit_died, CONNECT_DEFERRED)
	
	unit.health_updated.connect(func(_amt: int) -> void: attacked.emit())

func on_unit_died(unit: RtsUnit) -> void:
	print(unit.unit_name + " died! Rest in peace, little fella")
	if _selected_unit == unit:
		selected_unit = null
	
	# Because this has been connected with CALL_DEFERRED, this doesn't break things by freeing an object we need.
	units.remove_at(units.find(unit))
	unit_count_changed.emit(player_unit_count)
	unit.free()

	if player_unit_count == 0:
		all_player_units_died.emit()
