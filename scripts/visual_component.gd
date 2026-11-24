extends Component

@onready var down: Sprite3D = $Arrows/Down
@onready var up: Sprite3D = $Arrows/Up
@onready var left: Sprite3D = $Arrows/Left
@onready var right: Sprite3D = $Arrows/Right
@onready var space: Sprite3D = $Arrows/Jump
@onready var arrows: Node3D = $Arrows
const INPUT_THRESHOLD: float = 0.1

func _ready() -> void:
	super()
	dbc[CAN_DEFINITIONS.ID.MOVEMENT_INPUT] = arrow_update
	dbc[CAN_DEFINITIONS.ID.INPUT_VISUALISATIONS] = input_visual

func arrow_update(payload: Payload.InputPayload) -> void:
	if arrows.visible:
		var move_dir: Vector2 = payload.move_dir
		var space_state: bool = payload.is_space_pressed
		up.visible = move_dir.y < -INPUT_THRESHOLD
		down.visible = move_dir.y > INPUT_THRESHOLD
		left.visible = move_dir.x < -INPUT_THRESHOLD
		right.visible = move_dir.x > INPUT_THRESHOLD
		space.visible = space_state

func input_visual(payload: Payload.BoolPayload):
	arrows.visible = payload.boolean
