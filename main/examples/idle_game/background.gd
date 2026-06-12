extends TextureRect

@onready var idle_game: IdleGame = %idle_game

var _current_tween: Tween

func _ready() -> void:
	idle_game.counter_updated.connect(change_background)
	idle_game.lock_pressed.connect(toggle_lock)

func change_background() -> void:
	var next_color: Color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))

	if _current_tween:
		_current_tween.kill()

	_current_tween = get_tree().create_tween()
	_current_tween.set_trans(Tween.TRANS_QUART)
	_current_tween.tween_property(self, "modulate", next_color, 0.2)

func toggle_lock() -> void:
	if idle_game.counter_updated.is_connected(change_background):
		idle_game.counter_updated.disconnect(change_background)
	else:
		idle_game.counter_updated.connect(change_background)
