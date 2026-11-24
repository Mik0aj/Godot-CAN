extends Component


var current_input_data : Payload.InputPayload = Payload.InputPayload.new()
var input_visual : Payload.BoolPayload = Payload.BoolPayload.new()

var move_dir: Vector2 = Vector2.ZERO
var last_move_dir: Vector2 = Vector2.ZERO

var space_state: bool = false
var last_space_state: bool = false


func _process(_delta: float) -> void:
	move_dir.x = Input.get_axis("ui_left", "ui_right")
	move_dir.y = Input.get_axis("ui_up", "ui_down")

	if move_dir.length() > 1.0:
		move_dir = move_dir.normalized()

	space_state = Input.is_key_pressed(KEY_SPACE)
	
	if move_dir != last_move_dir or last_space_state !=space_state:
		current_input_data.set_input_data(move_dir,space_state)
		send_frame(CAN_DEFINITIONS.ID.MOVEMENT_INPUT,current_input_data)

	last_move_dir = move_dir
	last_space_state = space_state

	if Input.is_action_just_pressed("input_visual"):
		input_visual.boolean = !input_visual.boolean
		send_frame(CAN_DEFINITIONS.ID.INPUT_VISUALISATIONS,input_visual)
