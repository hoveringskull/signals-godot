class_name Unit3D extends Node3D

signal strike

@onready var animation_player: AnimationPlayer = %animation_player


func trigger_animation(key: StringName) -> void:
	animation_player.play(key)

func trigger_strike() -> void:
	strike.emit()

func _ready() -> void:
	animation_player.animation_finished.connect(func(anim) -> void: print("finish " + anim))
	animation_player.animation_started.connect(func(anim) -> void: print("start " + anim))
