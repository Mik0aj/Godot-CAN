extends Component


func _ready() -> void:
	super()
	dbc[CAN_DEFINITIONS.ID.EXAMPLE]=_simple_answer
	send_frame(CAN_DEFINITIONS.ID.EXAMPLE,Payload.Sample.new("msg"))


func _simple_answer(payload: Payload.Sample):
	send_frame(CAN_DEFINITIONS.ID.ACK,Payload.Sample.new("recived"))
