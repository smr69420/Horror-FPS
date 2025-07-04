extends CharacterBody3D
const SPEED = 5.0
signal stop_shooting

@export var jump_height: float = 1.0
@export var fall_multiplier: float = 2.5
@export var max_health:=80

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO
var stop_taking_input:=false

@onready var camera_pivot: Node3D = $CameraPivot
@onready var game_over_screen:Control=$GameOver


var current_health:int=max_health:
	set(value):
		current_health=value
		if current_health<=0:
			game_over_screen.visibility()
			var enemy_instance = get_parent().get_node("Enemy")
			if enemy_instance:
				enemy_instance.stop_attacking_after_player_death=true
				stop_taking_input=true
				emit_signal("stop_shooting")
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _physics_process(delta: float) -> void:
	if stop_taking_input==false:
		handle_camera_rotation()
		# Add the gravity.
		if not is_on_floor():
			if velocity.y >= 0:
				velocity.y -= gravity * delta
			else:
				velocity.y -= gravity * delta * fall_multiplier

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = sqrt(jump_height * 2.0 * gravity)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	
func _input(event: InputEvent) -> void:
	if stop_taking_input==false:
		if event is InputEventMouseMotion:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				mouse_motion = -event.relative * 0.002
		#if event.is_action_pressed("ui_cancel"):
			#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(
		camera_pivot.rotation_degrees.x, -90.0, 90.0
	)
	mouse_motion = Vector2.ZERO
	
func _process(delta:float) -> void:
	pass
	
