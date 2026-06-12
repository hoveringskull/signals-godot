class_name StatusPanel

var _selected_unit: Unit
var selected_unit: Unit:
	get: return _selected_unit
	set(value):
		if value == _selected_unit:
			return
		
		# Disconnect old signal
		unit.health_changed.disconnect(update_panel)

		_selected_unit = value

		# Connect to new unit signal
		unit.health_changed.connect(update_panel)

		update_panel()


func update_panel() -> void:
	label.text = unit.name
	hp_bar.value = unit.hp
	# etc.