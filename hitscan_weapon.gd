extends Node3D

@onready var timer:Timer=$Timer
@onready var recoil_animation:AnimationPlayer=$Recoil
@onready var raycast:RayCast3D=$RayCast3D

@export var fire_rate:=14.0
@export var recoil:=0.05
@export var weapon_damage:int=20
@export var weapon_mesh:Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(1.0/fire_rate) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if timer.is_stopped():
			shoot()


func shoot() -> void:
	var collider=raycast.get_collider()
	var flash:GPUParticles3D=$Gun_low_poly/Flash
	
	flash.restart()
	timer.start(1.0/fire_rate)
	printt("weapon fired",collider)
	recoil_animation.play("Recoil")
	if collider is Enemy:
		collider.current_health-=weapon_damage
		
