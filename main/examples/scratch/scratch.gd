extends Node2D

@onready var my_button = %my_button

func _ready() -> void:
	my_button.pressed.connect(do_thing)
	
	for i in range(3):
		var button = Button.new()
		add_child(button)
		button.pressed.connect(func() -> void: print("Calling a lambda!"))
	
		
	cleanup()
	
func do_thing() -> void:
	print("Thing done.")
	
func cleanup() -> void:
	my_button.pressed.disconnect(do_thing)
	# This works!
	
	my_button.queue_free()
	# This will also disconnect the signal.
	
	queue_free()
	# This will also disconnect the signal!
	
	
	
	
