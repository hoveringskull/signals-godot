class_name IdleGame extends PanelContainer

signal counter_updated()
signal counter_reset()
signal lock_pressed()

@onready var increment_button: Button = %increment_button
@onready var lock_button: Button = %lock_button
@onready var countdown_button: Button = %countdown_button
@onready var counter_label: Label = %counter_label

var _count: int = 0
var _timer: Timer

func _ready() -> void:
	# Connecting to a built-in signal (button.pressed)
	increment_button.pressed.connect(handle_press_increment)
	countdown_button.pressed.connect(handle_press_countdown)
	lock_button.pressed.connect(lock_pressed.emit)
	counter_label.text = str(_count)

	_timer = Timer.new()
	add_child(_timer)
	_timer.wait_time = 0.5
	# Connecting to a builtin signal (timer.timeout)
	_timer.timeout.connect(func() -> void: change_counter(-1))


func handle_press_increment() -> void:
	change_counter(1)

func handle_press_countdown() -> void:
	countdown()
	increment_button.disabled = true
	countdown_button.disabled = true
	await counter_reset
	increment_button.disabled = false
	countdown_button.disabled = false
	_timer.stop()
	

func countdown() -> void:
	_timer.start()

func change_counter(value: int) -> void:
	_count = max(_count + value, 0)
	counter_label.text = str(_count)
	counter_updated.emit()

	if _count == 0:
		counter_reset.emit()
