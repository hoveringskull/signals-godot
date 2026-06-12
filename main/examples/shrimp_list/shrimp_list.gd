extends Node2D

@onready var button_connect: Button = %button_connect
@onready var button_lambda_connect: Button = %button_lambda_connect
@onready var button_safe_connect: Button = %button_safe_connect
@onready var button_one_shot_connect: Button = %button_one_shot_connect
@onready var button_shrimp: Button = %button_shrimp
@onready var shrimp_list: Label = %shrimp_list

func _ready() -> void:
	button_connect.pressed.connect(handle_connect)
	button_lambda_connect.pressed.connect(handle_lambda_connect)
	button_one_shot_connect.pressed.connect(handle_one_shot_connect)
	button_safe_connect.pressed.connect(handle_safe_connect)

func handle_connect() -> void:
	# Will error on a second add of this specific connection. Bad, but you'll catch it.
	button_shrimp.pressed.connect(add_shrimp)

func handle_lambda_connect() -> void:
	# Can be added as many times as you want without warning -- this is dangerous!
	button_shrimp.pressed.connect(func() -> void: 
		print("Firing lambda")
		add_shrimp()
	)

func handle_one_shot_connect() -> void:
	button_shrimp.pressed.connect(add_shrimp, CONNECT_ONE_SHOT)

func handle_safe_connect() -> void:
	# Can only be added ONCE, and will silently ignore it if you try again. Safe.
	if not button_shrimp.pressed.is_connected(add_shrimp):
		button_shrimp.pressed.connect(add_shrimp)

func add_shrimp() -> void:
	shrimp_list.text = shrimp_list.text + "🦐"
