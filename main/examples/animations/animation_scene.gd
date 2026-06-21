extends Node3D

@onready var button_warrior_attack: Button = %button_warrior_attack
@onready var button_mage_attack: Button = %button_mage_attack
@onready var button_warrior_attack_tween: Button = %button_warrior_attack_tween
@onready var button_mage_attack_tween: Button = %button_mage_attack_tween
@onready var warrior: Unit3D = %warrior
@onready var mage: Unit3D = %mage

var attack_anim_name: StringName = &"skeleton_animations/Melee_1H_Attack_Chop"
var hurt_anim_name: StringName = &"skeleton_animations/Hit_A"
var idle_anim_name: StringName = &"skeleton_animations/Idle_A"

func _ready() -> void:
	warrior.trigger_animation(idle_anim_name)
	mage.trigger_animation(idle_anim_name)
	
	button_warrior_attack.pressed.connect(handle_attack.bind(warrior, mage))
	button_mage_attack.pressed.connect(handle_attack_coroutine.bind(mage, warrior))
	button_warrior_attack_tween.pressed.connect(handle_attack_await_tween.bind(warrior, mage))
	button_mage_attack_tween.pressed.connect(handle_attack_await_tween.bind(mage, warrior))

func handle_attack(attacker: Unit3D, victim: Unit3D) -> void:
	attacker.trigger_animation(attack_anim_name)
	if not attacker.strike.is_connected(handle_hurt):
		attacker.strike.connect(handle_hurt.bind(victim), CONNECT_ONE_SHOT)
		
func handle_attack_coroutine(attacker: Unit3D, victim: Unit3D) -> void:
	attacker.trigger_animation(attack_anim_name)
	await attacker.strike
	handle_hurt(victim)
	
func handle_hurt(unit: Unit3D) -> void:
	unit.trigger_animation(hurt_anim_name)	
	# We could add other stuff here too, like particles or sound effects

func handle_attack_await_tween(attacker: Unit3D, victim: Unit3D) -> void:
	var tween: Tween = get_tree().create_tween()
	# This would be more much interesting if we were doing other tween stuff already
	# but it could be a good way to support something like making them walk to eachother, or
	# firing a projectile
	tween.tween_callback(func() -> void: attacker.trigger_animation(attack_anim_name)).set_delay(0.01)
	# New in Godot 4.7! We can await tweens
	tween.tween_await(attacker.strike)
	tween.tween_callback(func() -> void: victim.trigger_animation(hurt_anim_name))
	
	
