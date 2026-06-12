class_name Unit

signal health_changed

var _health: int
var health: int:
	get: return _health 
	set(value):
		if value == _health:
			# This isn't a change, so we don't emit
			return

		_health = value
		health_changed.emit(self)