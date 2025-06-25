extends Node3D
@onready var anim_player = $AnimationPlayer
var frame_timer := 0.0
var frame_interval := 0.1 # 10 FPS
var current_anim := "eye_moving_4"
var current_pos := 0.0

func _ready():
	anim_player.play(current_anim)
	anim_player.pause() # We'll manually update it

func _process(delta):
	frame_timer += delta
	if frame_timer >= frame_interval:
		frame_timer = 0.0
		current_pos += frame_interval
		anim_player.seek(current_pos, true)
