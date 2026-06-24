class_name Unit3DCredits extends Node3D


@onready var animation_player: AnimationPlayer = %animation_player


func _ready() -> void:
	animation_player.play(&"skeleton_animations/T-Pose")

func _process(delta) -> void:
	rotate_y(3.5 * delta)
	translate(Vector3.UP * sin(Time.get_unix_time_from_system()) / 100.0)
