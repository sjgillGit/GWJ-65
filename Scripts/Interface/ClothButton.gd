extends ColorRect

#--------------------
# Interface for cloth icon
# Contains only interface logic
#--------------------

@onready var icon = $Icon


func _ready():
	assert(G.player != null, "please move player up in scene tree")
	G.player.cloth.is_on.connect(on_wear_cloth)
	G.player.cloth.is_removed.connect(on_take_off_cloth)


func on_wear_cloth(cloth_item: PickableItem) -> void:
	var item_icon = load("res://Assets/Interface/Icons/{code}.png".format({
		"code": cloth_item.code
	}))
	icon.texture = item_icon


func on_take_off_cloth(_backpack_item: PickableItem) -> void:
	icon.texture = null
