extends PickableItem

#--------------------
# Wearable item that contains array of other items
#
# To add Pickable item inside container from level start:
# Add item to level, set "is_in_container" to true
# Add link to item in backpack's "container" variable
#--------------------

class_name BackpackItem

@export var container: Array[ItemBase]
@export var items_count: int = 8


func use(hands_controller: HandsController) -> void:
	var backpack_controller = hands_controller.backpack_controller
	backpack_controller.open(self)


func interact(tool: String) -> void:
	if tool == "none": 
		super(tool)
		return
	G.player.backpack.put_active_item(self)


func wear(hands_controller: HandsController) -> void:
	var backpack_controller = hands_controller.backpack_controller
	if backpack_controller.backpack == null:
		move_item_to_parent(G.player.get_parent())
		visible = false
		freeze_item(true)
		hands_controller.set_active_item(null)
		backpack_controller.wear(self)


func take_off(hands_controller: HandsController) -> void:
	if hands_controller.get_active_item() == null:
		visible = true
		hands_controller.pick_item(self)
		position = Vector3.ZERO
		rotation = Vector3.ZERO
