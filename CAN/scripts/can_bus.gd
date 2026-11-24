class_name CANbus

extends Node


signal frame_emitted(msg_id: CAN_DEFINITIONS.ID, payload : Payload)

func broadcast(msg_id: CAN_DEFINITIONS.ID, payload  : Payload) -> void:
	frame_emitted.emit(msg_id, payload)

func broadcast_verbose(msg_id: CAN_DEFINITIONS.ID, payload  : Payload,sender:Object) -> void:
	CanDebugManager.log(msg_id , payload,get_parent() ,sender)
	broadcast(msg_id,payload)
