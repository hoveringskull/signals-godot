@warning_ignore_start("unused_signal")
# Note: we've ignored warnings in this file. Maybe we should take a hint though!
# There are many reasons to not use an event bus like this.
extends Node

signal unit_selected(unit: RtsUnitEB)
signal unit_clicked(unit: RtsUnitEB)
signal unit_health_updated(unit: RtsUnitEB)
signal unit_died(unit: RtsUnitEB)
signal unit_attacked(unit: RtsUnitEB)
