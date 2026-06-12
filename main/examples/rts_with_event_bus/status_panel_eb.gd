class_name StatusPanelEB extends PanelContainer

@onready var label_unit_name: Label = %label_unit_name
@onready var progress_bar_unit_hp: TextureProgressBar = %progress_bar_unit_hp
@onready var label_unit_weapon: Label = %label_unit_weapon

var _unit: RtsUnitEB
var unit: RtsUnitEB:
	get: return _unit
	set(value):
		if value == _unit:
			return

		_unit = value
		if _unit == null:
			hide()
			return
		else:
			update()


func _ready() -> void:
	RtsEventBus.unit_health_updated.connect(on_health_updated)

func update() -> void:
	if not unit:
		hide()
		return
	
	show()
	
	label_unit_name.text = unit.unit_name
	progress_bar_unit_hp.max_value = unit.max_hp
	progress_bar_unit_hp.value = unit.current_hp
	label_unit_weapon.text = unit.weapon_name

func on_health_updated(updated_unit: RtsUnitEB) -> void:
	if unit != updated_unit:
		# Since this fires for EVERY unit now, we need to check every time
		return

	progress_bar_unit_hp.value = unit.current_hp
