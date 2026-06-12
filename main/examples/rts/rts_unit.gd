class_name RtsUnit extends AnimatedSprite2D

signal clicked(unit: RtsUnit)
signal health_updated(number: int)
signal died(unit: RtsUnit)

@export var unit_name: String
@export var weapon_name: String
@export var max_hp: int
@export var current_hp: int
@export var damage: int

@onready var selection_indicator: Sprite2D = %selection
@onready var clickable: Area2D =  %clickable

func _ready() -> void:
	play(&"default")
	clickable.input_event.connect(on_input_event)

func on_select() -> void:
	selection_indicator.show()

func on_deselect() -> void:
	selection_indicator.hide()

func on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		clicked.emit(self)

func take_damage(amount: int) -> void:
	current_hp -= amount

	if current_hp <= 0:
		died.emit(self)
		play(&"die")
		return

	var damage_tween: Tween = get_tree().create_tween()
	damage_tween.tween_property(self, "modulate", Color.RED, 0.05)
	damage_tween.tween_property(self, "modulate", Color.WHITE, 0.02)

	health_updated.emit(current_hp)
