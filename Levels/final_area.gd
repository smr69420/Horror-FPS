extends CSGBox3D

@onready var player:CharacterBody3D=$"../../../../Player"

func _on_exit_detection_body_entered(body: Node3D) -> void:
	if body==player:
		get_tree().quit()
