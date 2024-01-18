extends PickableItem


#--------------------
# Wearable item in cloth slot
#--------------------

class_name ClothItem


func wear(hands_controller: HandsController) -> void:
	var cloth_controller = hands_controller.cloth_controller
	if cloth_controller.cloth == null:
		move_item_to_parent(G.player.get_parent())
		visible = false
		freeze_item(true)
		hands_controller.set_active_item(null)
		cloth_controller.wear(self)


func take_off(hands_controller: HandsController) -> void:
	if hands_controller.get_active_item() == null:
		visible = true
		hands_controller.pick_item(self)
		position = Vector3.ZERO
		rotation = Vector3.ZERO
