class_name ObserverClass

func _ready() -> void:
	subject.important_thing_happened.connect(on_important_thing_happened)

	subject.important_thing_happened.disconnect(on_important_thing_happened)


func on_important_thing_happened() -> void:
	print("Something important just happened!")