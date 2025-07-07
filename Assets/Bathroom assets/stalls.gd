extends Node3D

@onready var knocking:AudioStreamPlayer3D=$Knocking

var emission=0


func _on_bathroom_detection_body_exited(body: Node3D) -> void:
	if emission==0:
		knocking.play()
		emission=emission+1
