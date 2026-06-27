class_name Unit3D extends Node3D

signal strike

@onready var animation_player: AnimationPlayer = %animation_player

# For collision-based reactions only:
@onready var hit_box: Area3D = %hit_box
@onready var hurt_box: HurtBox = %hurt_box
var _is_attacking: bool


func trigger_animation(key: StringName) -> void:
	animation_player.play(key)

func trigger_strike() -> void:
	strike.emit()

func _ready() -> void:
	hurt_box.bound_unit = self
	hit_box.area_entered.connect(on_hit_box_entered)


# For collision-based attacks only;
# This is a very rough outline of what you can do with this, and would require
# lots more machinery to make it work in an actual game!

func on_hit_box_entered(collided_with: Area3D) -> void:
	if  collided_with == hurt_box:
		# Ignore self collision
		return
		
	# This is a hacky way of doing this part -- adapt it to your needs
	var box: HurtBox = collided_with as HurtBox
	if box:
		var hurt_unit: Unit3D = box.bound_unit
		hurt_unit.trigger_animation(&"skeleton_animations/Hit_A")
		hurt_unit.take_damage(35)

func do_collision_attack(animation_name: StringName) -> void:
	if _is_attacking:
		return
	
	_is_attacking = true
	toggle_hit_box(true)
	trigger_animation(animation_name)
	animation_player.animation_finished.connect(on_attack_finished, CONNECT_ONE_SHOT)
	
	# Problems for you to figure out:
	# What happens if a single attack leaves and re-enters the collider?
	# Do we want these to strike multiple colliders?
	# How do we handle multiple different animation types?
	# Where is it best to react to this to update data? Probably not here, but this is just an example.
	# Probably need to cooldown/disallow animation cancelling.
	# Probably need to do some layer management to make sure you're only colliding with legit boxes
	# etc. etc.
	
func on_attack_finished(_anim_name: StringName) -> void:
	_is_attacking = false
	toggle_hit_box(false)
	
func toggle_hit_box(on: bool):
	for child: Node in hit_box.get_children():
		var shape: CollisionShape3D = child as CollisionShape3D
		if shape:
			shape.disabled = !on

func take_damage(amount: int) -> void:
	# For turn based implementations, this should be called separately from
	# physics and animations; for the realtime collision version, we can't
	# decouple this.
	print("I took damage: " + str(amount))
