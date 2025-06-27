extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var timer=$Timer

var frame_timer := 0.0
var frame_interval := 0.1 # 10 FPS
var current_anim := "eye_moving_4"
var current_pos := 0.0
var animations=["eye_moving_2","eye_moving_3","eye_moving_4"]

func _ready() ->void:
	randomize()
	var random_wait_time=randfn(0.0,2.0)
	timer.start(random_wait_time)

func _process(delta):
	frame_timer += delta
	if frame_timer >= frame_interval:
		frame_timer = 0.0
		current_pos += frame_interval
		anim_player.seek(current_pos, true)


func _on_timer_timeout() -> void:
	var random_animation=animations[randi() %animations.size()]
	anim_player.play(random_animation)
	anim_player.pause() # We'll manually update it
