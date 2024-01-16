extends ColorRect

#--------------------
# Interface for backpack icon
# Contains only interface logic
#--------------------

@onready var icon = $Icon


func _ready():
	assert(G.player != null, "please move player up in scene tree")
	G.player.inventory.wear_backpack.connect(on_wear_backpack)
	G.player.inventory.take_off_backpack.connect(on_take_off_backpack)


func on_wear_backpack(_active_hand_type: Enums.HandType, code: String) -> void:
	var item_icon = load("res://Assets/Interface/Icons/{code}.png".format({
			"code": code
		}))
	icon.texture = item_icon


func on_take_off_backpack(_active_hand_type: Enums.HandType, _code: String) -> void:
	icon.texture = null
