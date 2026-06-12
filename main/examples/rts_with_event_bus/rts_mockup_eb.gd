extends Node2D

@onready var status_panel: StatusPanelEB = %status_panel
@onready var attack_alert_label: AttackAlertLabelEB = %attack_alert_label
@onready var units_node: Node2D = %units

@export var player_unit: PackedScene
@export var enemy_unit: PackedScene

var units: Array[RtsUnitEB] = []

var _selected_unit: RtsUnitEB
var selected_unit: RtsUnitEB:
	get: return _selected_unit
	set(value):
		if value == _selected_unit:
			return

		if _selected_unit:
			_selected_unit.on_deselect()

		_selected_unit = value
		if _selected_unit:
			_selected_unit.on_select()
			RtsEventBus.unit_selected.emit(_selected_unit)
		status_panel.unit = _selected_unit


func _ready() -> void:
	setup()

	RtsEventBus.unit_clicked.connect(func(clicked_unit: RtsUnitEB) -> void: self.selected_unit = clicked_unit)
	RtsEventBus.unit_died.connect(on_unit_died)
	RtsEventBus.unit_health_updated.connect(RtsEventBus.unit_attacked.emit)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"trigger_event_0"):
		event_0()

func add_unit(scene: PackedScene, spawn_position: Vector2) -> void:
	var unit: RtsUnitEB = scene.instantiate() as RtsUnitEB
	units_node.add_child(unit)
	units.append(unit)
	unit.position = spawn_position

func on_unit_died(unit: RtsUnitEB) -> void:
	# Do something here to clean up unit; I'm leaving it for now though
	print(unit.unit_name + " died! Rest in peace, little fella")
	if _selected_unit == unit:
		selected_unit = null



# DEMO ONLY, BEWARE: THERE BE SLOPPY AD-HOC CODE BELOW
func setup() -> void:
	add_unit(player_unit, Vector2(234, 114))
	add_unit(player_unit, Vector2(140, 120))
	add_unit(enemy_unit, Vector2(113, 92))
	add_unit(enemy_unit, Vector2(103, 143))
	add_unit(enemy_unit, Vector2(151, 93))


func event_0() -> void:
	# Weasel attacks bunny
	var weasel = units[3]
	var bunny = units[1]

	var tween = get_tree().create_tween()
	tween.tween_property(weasel, "position", bunny.position, 0.1)
	tween.tween_callback(func() -> void: 
		bunny.take_damage(weasel.damage)
	)
	tween.tween_property(weasel, "position", Vector2(103, 143), 0.1)
