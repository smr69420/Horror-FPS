extends CharacterBody3D
class_name Enemy

const SPEED = 4.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player:AnimationPlayer=$AnimationPlayer

@export var attack_range:float=1.5
@export var max_health:int=100


var player
var provoked:=false
var aggro_range :=12.0
var current_health:int=max_health:
	set(value):
		current_health=value	
		if current_health<=0:
			queue_free()
		provoked=true

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	navigation_agent_3d.target_position = player.global_position

func _physics_process(delta: float) -> void:
	var next_position = navigation_agent_3d.get_next_path_position()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	var direction=global_position.direction_to(next_position)
	var distance=global_position.distance_to(player.global_position)
	
	if provoked==true:
		if attack_range>distance:
			animation_player.play("Attack")
		#make the character rotate
		look_at_target(direction)
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	
	if distance<aggro_range:
		provoked=true
		#kinda cool if u want the enemy to keep rotatingrotate_y(direction.y)
	

	move_and_slide()
	
func look_at_target(direction:Vector3) -> void:
	var adjusted_direction=direction
	adjusted_direction.y=0
	if direction!=global_position:
		look_at(global_position+adjusted_direction,Vector3.UP,true) #adding it bcz look at funcn uses global position
func attacked() -> void:
	print("dead lmao")
