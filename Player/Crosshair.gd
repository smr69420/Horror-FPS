@tool
extends Control

func _draw() -> void:
	draw_circle(Vector2.ZERO, 4, Color.DIM_GRAY)
	draw_circle(Vector2.ZERO, 3, Color.WHITE)
	
	draw_line(Vector2(16, 0), Vector2(24, 0), Color.WHITE, 2)
	draw_line(Vector2(-16, 0), Vector2(-24, 0), Color.WHITE, 2)
	
	draw_line(Vector2(0, 16), Vector2(0, 24), Color.WHITE, 2)
	draw_line(Vector2(0, -16), Vector2(0, -24), Color.WHITE, 2)
