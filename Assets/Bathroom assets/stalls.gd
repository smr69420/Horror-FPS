extends Node3D

@onready var knocking:AudioStreamPlayer3D=$Knocking
@onready var rain_bus_index = AudioServer.get_bus_index("Rain")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var window:CSGBox3D=$"../../Window6"

var emission=0
var processing=0

func _on_bathroom_detection_body_exited(body: Node3D) -> void:
	if emission==0:
		knocking.play()
		emission=emission+1
		processing=processing+1
		
func _process(delta: float) -> void:
	var current_volume = AudioServer.get_bus_volume_db(rain_bus_index)
	if processing!=0:
		var dist = player.global_position.distance_to(window.global_position)
		var target_volume = clamp(-10.0 - dist * 1.0, -80.0, -10.0)
		var new_volume = lerp(current_volume, target_volume, delta * 2.0)
		AudioServer.set_bus_volume_db(rain_bus_index, new_volume)
