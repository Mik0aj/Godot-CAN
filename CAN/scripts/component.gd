class_name Component
extends Node

var CAN_bus: CANbus
var broadcast: Callable

var dbc: Dictionary[CAN_DEFINITIONS.ID, Callable] 

func _ready() -> void:
	_set_up_bus()
	if OS.is_debug_build():
		broadcast = CAN_bus.broadcast_verbose.bind(self)
	else:
		broadcast = CAN_bus.broadcast
	CAN_bus.frame_emitted.connect(process_CAN_frame)
	
func process_CAN_frame(msg_id: CAN_DEFINITIONS.ID, payload: Payload)-> void:
	if dbc.has(msg_id):
		dbc[msg_id].call(payload)
	
func send_frame(msg_id: CAN_DEFINITIONS.ID, payload: Payload) -> void:
	broadcast.call(msg_id,payload)
	
func _set_up_bus()-> void:
	var parent = get_parent()
	while true:
		if parent.is_in_group("CAN_terminator"):
			CAN_bus = parent.find_child("CANbus")
			if CAN_bus:
				break
			else:
				push_error("Missing CANbus node")
				return
		else:
			parent = parent.get_parent()
			if parent == null:
				push_error("Missing parent node or no terminator")
				return
