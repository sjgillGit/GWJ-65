extends Node


#--------------------
# Handles wearing and taking off cloth
#--------------------

class_name ClothController

@onready var hands_controller: HandsController = get_node("../HandsController")
@onready var backpack_controller: BackpackController = get_node("../BackpackController")

var cloth: PickableItem
var skip_one_frame: bool

signal is_on(cloth_item: PickableItem)
signal is_removed(cloth_item: PickableItem)


func _process(_delta) -> void:
	if skip_one_frame:
		skip_one_frame = false
		return
	
	if Input.is_action_just_pressed("ui_wear") and cloth != null:
		take_off()


func wear(new_cloth: PickableItem) -> void:
	is_on.emit(new_cloth)
	cloth = new_cloth
	skip_one_frame = true
	backpack_controller.skip_one_frame = true


func take_off() -> void:
	if hands_controller.get_active_item() == null:
		var old_cloth = cloth
		cloth = null
		is_removed.emit(old_cloth)
		old_cloth.take_off(hands_controller)
