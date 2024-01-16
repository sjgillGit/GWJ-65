extends PickableItem

#--------------------
# Wearable item that contains array of other items
#--------------------

class_name BackpackItem

@export var container: Array[ItemBase]


func wear(inventory: Inventory) -> void:
	if inventory.backpack == null:
		visible = false
		move_item_to_parent(G.player.get_parent())


func take_off(inventory: Inventory) -> void:
	if inventory.get_active_item() == null:
		visible = true
		move_item_to_parent(inventory.get_active_hand_parent())
		position = Vector3.ZERO
		rotation = Vector3.ZERO
