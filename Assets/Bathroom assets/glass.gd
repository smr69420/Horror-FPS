class_name Glass
extends Node3D

@onready var rigid_body=$RigidBody
@onready var glass_shattering_animation=$AnimationPlayer
@onready var timer=$Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rigid_body.gravity_scale=0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable_gravity() -> void:
	glass_shattering_animation.play("glass_shattering")
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
