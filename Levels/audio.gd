extends Node3D
@onready var rain=$Rain
@onready var rain_bus_index = AudioServer.get_bus_index("Rain")
@onready var window:Node3D=$"../Raineffects/window with rain6"

var fading_out=false
var fading_in
var fade_out_speed := 1.0
var player

func _ready() -> void:
	rain.stream
	rain.bus = "Rain"
	AudioServer.set_bus_volume_db(rain_bus_index, -10.0)
	rain.play()
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	var current_volume = AudioServer.get_bus_volume_db(rain_bus_index)
	if fading_out:
		var dist = player.global_position.distance_to(window.global_position)
		var target_volume = clamp(-10.0 - dist * fade_out_speed, -80.0, -10.0)
		var new_volume = lerp(current_volume, target_volume, delta * 2.0) # smooth fade
		AudioServer.set_bus_volume_db(rain_bus_index, new_volume)
	elif fading_in:
		var new_volume=lerp(current_volume,-10.0,delta*2.0)
		AudioServer.set_bus_volume_db(rain_bus_index, new_volume)


func _on_hallwaydetection_body_exited(body: Node3D) -> void:
	fading_out=true


func _on_hallwaydetection_body_entered(body: Node3D) -> void:
	fading_out=false
	fading_in=true
	#AudioServer.set_bus_volume_db(rain_bus_index, -10.0)
