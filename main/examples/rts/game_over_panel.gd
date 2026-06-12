class_name GameOverPanel extends PanelContainer

signal reset_pressed()

@onready var restart_button: Button = %restart_button

func _ready() -> void:
	restart_button.pressed.connect(reset_pressed.emit)
	hide()

func pop() -> void:
	show()

func set_trigger(pop_signal: Signal) -> void:
	# Because we can take ANY signal in here, we can reuse this for ANYTHING. Just pass in a signal.
	pop_signal.connect(pop)
