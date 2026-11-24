extends Node

var logging :bool = true
var debug :bool  = true
var messages : Array[Array]

@export var log_file_path: String = "res://log.csv"
var file 


func _ready() -> void:
	print("CAN debug manager started.")
	if !file:
		file = FileAccess.open(log_file_path, FileAccess.WRITE)
		
func set_logging(new_val:bool):
	logging = new_val
func set_debug(new_val:bool):
	debug = new_val

func log(msg_id: CAN_DEFINITIONS.ID, payload  : Payload,source_can : Object,sender:Object):
	var msg_name: String = CAN_DEFINITIONS.ID.find_key(msg_id)
	var payload_str: String = payload.serialize()
	var time_str := Time.get_time_string_from_system()
	var time_str_in_ms := Time.get_ticks_usec()
	var debug_information = [time_str,time_str_in_ms,source_can,sender,msg_name, payload_str]
	if debug:
		print_rich("[color=Lightslategray]%s[/color] ; [color=Lightslategray]%s[/color] ; [color=Lightblue]%s[/color] ; [color=Lightgreen]%s[/color] ; [color=Lightseagreen]%s[/color] ; [color=Darkkhaki]%s[/color]" % debug_information)
	if logging:
		_log_to_file(debug_information)
	messages.append(debug_information)

func print_messages():
	if messages:
		for message in messages:
			print(message)

# Extracts export/script variables into a readable string
func _serialize_payload(payload: Resource) -> String:
	if not payload:
		return "null"
		
	var dict := {}
	if payload.get_script():
		for prop in payload.get_script().get_script_property_list():
			dict[prop.name] = payload.get(prop.name)
		return str(dict)

	return payload.to_string()

# Appends formatted message entry to local user directory file
func _log_to_file(logging_information : Array) -> void:
	var log_line := "%s ; %s ; %s ; %s ; %s ; %s\n" % logging_information

	if file:
		file.seek_end() # Move cursor to end of file to append
		file.store_string(log_line)
	else :
		printerr("File cannot be null.")
func _exit_tree() -> void:
	if file:
		file.close()
