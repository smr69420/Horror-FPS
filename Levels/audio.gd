extends Node3D
@onready var rain=$Rain
@onready var rain_bus_index = AudioServer.get_bus_index("Rain")

var fading_out=false
var fading_in
var fade_out_speed := 1.0

func _ready() -> void:
	rain.stream
	rain.bus = "Rain"
	AudioServer.set_bus_volume_db(rain_bus_index, -20.0)
	rain.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out:
		var current_volume=AudioServer.get_bus_volume_db(rain_bus_index)
		if current_volume>-40:
			AudioServer.set_bus_volume_db(rain_bus_index, current_volume - fade_out_speed * delta)
		else:
			fading_out=false


func _on_hallwaydetection_body_exited(body: Node3D) -> void:
	fading_out=true


func _on_hallwaydetection_body_entered(body: Node3D) -> void:
	AudioServer.set_bus_volume_db(rain_bus_index, -10.0)
