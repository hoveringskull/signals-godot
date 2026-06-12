extends Node2D


@onready var status_panel: StatusPanel = %status_panel
@onready var attack_alert_label: AttackAlertLabel = %attack_alert_label
@onready var units_left_label: UnitsLeftLabel = %units_left_label
@onready var game_over_panel: GameOverPanel = %game_over_panel

@export var player_unit: PackedScene
@export var enemy_unit: PackedScene

var unit_container: UnitContainer

func _ready() -> void:
	unit_container = UnitContainer.new()
	add_child(unit_container)
	game_over_panel.reset_pressed.connect(reset)

	# We can pass a signal as an argument, and let game_over_panel 
	# bind itself to it
	game_over_panel.set_trigger(unit_container.all_player_units_died)
	
	unit_container.unit_selected.connect(status_panel.set_unit)
	unit_container.unit_count_changed.connect(units_left_label.update.emit, CONNECT_DEFERRED)
	unit_container.attacked.connect(attack_alert_label.show)
	setup()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"trigger_event_0"):
		event_0()

func reset() -> void:
	get_tree().reload_current_scene()

func setup() -> void:
	unit_container.add_unit(player_unit, Vector2(234, 114))
	unit_container.add_unit(player_unit, Vector2(140, 120))
	unit_container.add_unit(enemy_unit, Vector2(103, 143))
	unit_container.add_unit(enemy_unit, Vector2(113, 92))
	unit_container.add_unit(enemy_unit, Vector2(151, 93))

# DEMO ONLY, BEWARE: THERE BE SLOPPY AD-HOC CODE BELOW

func event_0() -> void:
	# Weasel attacks bunny
	var weasel_index: int = unit_container.units.find_custom(func(unit) -> bool: return unit.unit_name == "Weasel Patrol")
	var weasel: RtsUnit = unit_container.units[weasel_index]
	var bunny_index: int = unit_container.units.find_custom(func(unit) -> bool: return unit.unit_name == "Bunny Marine")
	var bunny: RtsUnit = unit_container.units[bunny_index]

	if bunny and weasel:
		var saved_pos = weasel.position
		var tween = get_tree().create_tween()
		tween.tween_property(weasel, "position", bunny.position, 0.1)
		tween.tween_callback(func() -> void: 
			bunny.take_damage(weasel.damage)
		)
		tween.tween_property(weasel, "position", saved_pos, 0.1)
