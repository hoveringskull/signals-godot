class_name StatusPanel extends PanelContainer

@onready var label_unit_name: Label = %label_unit_name
@onready var progress_bar_unit_hp: TextureProgressBar = %progress_bar_unit_hp
@onready var label_unit_weapon: Label = %label_unit_weapon

var _unit: RtsUnit
var unit: RtsUnit:
	get: return _unit
	set(value):
		if value == _unit:
			return

		if _unit:
			_unit.health_updated.disconnect(on_health_updated)

		_unit = value
		if _unit == null:
			hide()
			return
		else:
			_unit.health_updated.connect(on_health_updated)
			update()


func update() -> void:
	if not unit:
		hide()
		return
	
	show()
	
	# PULL model: if this were called from a signal, we look for all the data in here
	label_unit_name.text = unit.unit_name
	progress_bar_unit_hp.max_value = unit.max_hp
	progress_bar_unit_hp.value = unit.current_hp
	label_unit_weapon.text = unit.weapon_name

func on_health_updated(number: int) -> void:
	# PUSH model -- the data is passed in the signal
	progress_bar_unit_hp.value = number
	
func set_unit(new_unit: RtsUnit) -> void:
	unit = new_unit
	
	
	
	
