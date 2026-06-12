class_name ObserverClass

var subject: SubjectClass
var label: Label

func _process(delta) -> void:
	# This runs every frame; not an efficient way to update!
	label.text = subject.some_value