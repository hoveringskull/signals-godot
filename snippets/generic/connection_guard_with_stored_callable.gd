var some_stored_lambda: Callable

func _ready() -> void:
	# This works
	if not subject.important_thing_happened.is_connected(some_stored_lambda):
		subject.important_thing_happened.connect(some_stored_lambda)

	# This won't
	if not subject.important_thing_happened.is_connected(func() -> void: print("Hi")):
		subject.important_thing_happened.connect(func() -> void: print("Hi"))