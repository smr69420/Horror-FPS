extends Node3D

@onready var idle:AnimationPlayer=$AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	idle.play("mixamo_com")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
