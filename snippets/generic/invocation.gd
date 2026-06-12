class_name SubjectClass

var observer: ObserverClass

func some_function() -> void:
	# This requires that the subject class has a reference to observer,
	# and commits to the do_something() implementation!
	observer.do_something() 