extends ColorRect

#--------------------
# Interface for backpack icon
# Contains only interface logic
#--------------------

@onready var icon = $Icon


func _ready():
	assert(G.player != null, "please move player up in scene tree")
	G.player.backpack.is_on.connect(on_wear_backpack)
	G.player.backpack.is_removed.connect(on_take_off_backpack)


func on_wear_backpack(backpack_item: BackpackItem) -> void:
	var item_icon = load("res://Assets/Interface/Icons/{code}.png".format({
			"code": backpack_item.code
		}))
	icon.texture = item_icon


func on_take_off_backpack(_backpack_item: BackpackItem) -> void:
	icon.texture = null
