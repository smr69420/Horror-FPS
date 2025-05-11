extends Control


func visibility() -> void:
	visible=true
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene() 


func _on_end_button_pressed() -> void:
	get_tree().quit() 
