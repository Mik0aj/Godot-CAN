class_name Payload 

extends Resource

func serialize():
	return

class BoolPayload extends Payload:
	var boolean: bool = false:
		set(value):
			boolean = value
			
	func serialize() -> String:
		return "%s" % boolean
		
class InputPayload extends Payload:

	var move_dir: Vector2 = Vector2.ZERO:
		set(value):
			move_dir = value

	var is_space_pressed: bool = false:
		set(value):
			is_space_pressed = value

	func set_input_data(p_move_dir: Vector2, p_is_space_pressed: bool) -> void:
		move_dir = p_move_dir
		is_space_pressed = p_is_space_pressed

	func serialize() -> String:
		return "%s %s %s" % [move_dir.x, move_dir.y, is_space_pressed]

class Sample extends Payload:
	var some_message: String

	func _init(p_message: String = "") -> void:
		some_message = p_message

	func serialize() -> String:
		return some_message
