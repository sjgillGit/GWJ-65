extends ItemBase


func interact(tool: String) -> void:
	if tool != "none": 
		return
	print("item is picked!")
	G.player.inventory.set_active_item(code)
	queue_free()
