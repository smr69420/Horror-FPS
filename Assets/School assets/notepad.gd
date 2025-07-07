extends Node3D

var player
var queue=0

@export var textrange:=1

@onready var log:Control=$Log1
@onready var closed_area:CSGBox3D=$ClosedArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distance=global_position.distance_to(player.global_position)
	#print("Distance to player:", distance)
	if Input.is_action_pressed("exit"):
		log.visible=false
	if distance<=textrange:
		if Input.is_action_just_pressed("interact"):
			log.visible=true
			if queue==0:
				closed_area.queue_free()
				queue=queue+1
		if Input.is_action_pressed("exit"):
				log.visible=false
