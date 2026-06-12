func some_function() -> void:
	Events.something_happened.connect(do_something)
	Events.dinner_ready.emit()

func do_something() -> void:
	pass
