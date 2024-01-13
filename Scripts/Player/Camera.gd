extends Camera3D

#--------------------
# Rotating FPS camera by mouse
#--------------------

@onready
var controller_node: Node3D = get_node('../')
@onready
var player: Node3D = get_node('../../')

const MOUSE_SENSITIVITY = 0.1
const MIN_Y_ROT = -70
const MAX_Y_ROT = 70


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		update_camera_rotation(event)


func update_camera_rotation(event: InputEventMouseMotion) -> void:
	controller_node.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	player.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
	
	var camera_rot = controller_node.rotation_degrees
	camera_rot.y = clamp(camera_rot.y, MIN_Y_ROT, MAX_Y_ROT)
	controller_node.rotation_degrees = camera_rot
