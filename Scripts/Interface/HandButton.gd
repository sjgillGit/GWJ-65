extends Button

#--------------------
# Interface for hand holding an item
# Contains only interface logic
#--------------------

class_name HandButton

@export var hand_type: Enums.HandType
@export var is_active: bool

@onready var active_borders = $ActiveBorders
@onready var item_icon = $Icon

var current_item: PickableItem


func _ready():
	if is_active: set_active(true)
	match hand_type:
		Enums.HandType.LEFT:
			$LeftHandLabel.visible = true
		Enums.HandType.RIGHT:
			$RightHandLabel.visible = true
	
	assert(G.player != null, "please move player up in scene tree")
	G.player.hands.active_hand_switched.connect(on_active_hand_switched)
	G.player.hands.item_picked.connect(on_pick_item)
	G.player.hands.item_dropped.connect(on_drop_item)
	G.player.backpack.is_on.connect(on_wear_item)
	G.player.backpack.is_removed.connect(on_pick_item)
	G.player.backpack.item_is_packed_to_backpack.connect(on_drop_item)


func on_active_hand_switched() -> void:
	set_active(!is_active)


func set_active(new_active: bool) -> void:
	is_active = new_active
	active_borders.visible = new_active


func on_pick_item(item: PickableItem) -> void:
	if G.player.hands.active_hand == hand_type:
		current_item = item
		var icon_resource = load("res://Assets/Interface/Icons/{code}.png".format({
			"code": item.code
		}))
		item_icon.texture = icon_resource


func on_drop_item() -> void:
	if G.player.hands.active_hand == hand_type:
		item_icon.texture = null
		current_item = null


func on_wear_item(_item: PickableItem) -> void:
	if G.player.hands.active_hand == hand_type:
		item_icon.texture = null
		current_item = null


func _on_pressed():
	var opened_backpack = G.player.backpack.opened_backpack
	if opened_backpack != null:
		if current_item == opened_backpack:
			G.player.backpack.close()
		else:
			G.player.backpack.put_active_item(null)
