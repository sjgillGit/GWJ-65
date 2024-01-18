extends Button

#--------------------
# Interface for backpack item in BackpackMenu
#--------------------

class_name BackpackMenuItem

@onready var item_icon: TextureRect = get_node("Icon")
@onready var menu: BackpackMenu = get_node("../../")
var item_id: int


func _on_pressed():
	if item_id >= 0 and G.player.hands.get_active_item() == null:
		G.player.backpack.get_item(item_id)


func load_item(item_code: String, id: int) -> void:
	disabled = false
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var icon_resource = load("res://Assets/Interface/Icons/{code}.png".format({
		"code": item_code
	}))
	item_icon.texture = icon_resource
	item_id = id


func clear_item() -> void:
	disabled = true
	mouse_default_cursor_shape = Control.CURSOR_ARROW
	item_icon.texture = null
	item_id = -1
