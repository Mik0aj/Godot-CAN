extends Component

@export var speed: float = 6.0
@export var jump_impulse: float = 5.0
@export var rotation_speed: float = 8.0 # Speed for turning left/right

@onready var rigid_body: CharacterBody3D = $CharacterBody

var move_dir: Vector2 = Vector2.ZERO
var space_state: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	super()
	dbc[CAN_DEFINITIONS.ID.MOVEMENT_INPUT] = move

func move(payload: Payload.InputPayload) -> void:
	move_dir = payload.move_dir
	if rigid_body and rigid_body.is_on_floor():
		space_state = payload.is_space_pressed

func _physics_process(delta: float) -> void:
	if not rigid_body:
		return
	# 1. Apply Gravity
	if not rigid_body.is_on_floor():
		rigid_body.velocity.y -= gravity * delta
	# 2. Rotate Character based on Horizontal Input (X-axis)
	if move_dir.x != 0.0:
		rigid_body.rotate_y(-move_dir.x * rotation_speed * delta)
	# 3. Calculate Forward/Backward Movement relative to Character Facing Direction
	# Negative Z in Godot 3D is forward
	var local_dir := (rigid_body.global_transform.basis.z * move_dir.y).normalized()
	rigid_body.velocity.x = local_dir.x * speed
	rigid_body.velocity.z = local_dir.z * speed
	# 4. Jump Handling
	if space_state:
		if rigid_body.is_on_floor():
			rigid_body.velocity.y = jump_impulse
		space_state = false
	# 5. Execute Movement
	rigid_body.move_and_slide()
