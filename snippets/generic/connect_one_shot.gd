class_name ObserverClass

func _ready() -> void:
	subject.important_thing_happened.connect(on_important_thing_happened, CONNECT_ONE_SHOT)

func on_important_thing_happened() -> void:
	print("Something important just happened, but it won't happen again!")
