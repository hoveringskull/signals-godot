class_name RtsUnitNoSignals extends AnimatedSprite2D

@export var current_hp: int

var status_panel: StatusPanel
var unit_container: UnitContainer
var blood_spawner_extra_gooshy: GooshYBloodSpawner
var nasty_sfx_generator: NastySFXGenerator
var some_other_random_stuff: RandomStuff
var all_the_other_ui_we_need: MoreUIStuff
var this_is_not_good: Truth


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
		status_panel.unit = self

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
