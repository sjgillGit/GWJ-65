extends ColorRect

#--------------------
# Container-interface for backpack items
#--------------------

class_name BackpackMenu

var menu_items: Array[BackpackMenuItem]
var opened_backpack: BackpackItem


func _ready()-> void:
	for child in get_node("Items").get_children():
		menu_items.push_back(child)
	
	assert(G.player != null, "please move player up in scene tree")
	G.player.backpack.is_opened.connect(on_open_backpack)
	G.player.backpack.is_closed.connect(on_close_backpack)
	G.player.backpack.item_is_removed_from_backpack.connect(load_items)
	G.player.backpack.item_is_packed_to_backpack.connect(load_items)


func on_open_backpack(backpack: BackpackItem) -> void:
	opened_backpack = backpack
	load_items()
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func on_close_backpack() -> void:
	opened_backpack = null
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func load_items() -> void:
	if opened_backpack == null: return
	
	for i in range(menu_items.size()):
		if opened_backpack.container.size() <= i: 
			menu_items[i].clear_item()
		else:
			menu_items[i].load_item(opened_backpack.container[i].code, i)
