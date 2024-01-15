extends Control

#--------------------
# Interface for hand holding an item
# Contains only interface logic
#--------------------

class_name HandButton

@export var hand_type: Enums.HandType
@export var is_active: bool

var active: bool = false

@onready var active_borders = $ActiveBorders
@onready var icon = $Icon


func _ready():
	if is_active: set_active(true)
	match hand_type:
		Enums.HandType.LEFT:
			$LeftHandLabel.visible = true
		Enums.HandType.RIGHT:
			$RightHandLabel.visible = true
	
	assert(G.player != null, "please move player up in scene tree")
	G.player.inventory.active_hand_switched.connect(on_active_hand_switched)
	G.player.inventory.item_picked.connect(on_pick_item)
	G.player.inventory.item_dropped.connect(on_drop_item)


func on_active_hand_switched() -> void:
	set_active(!active)


func set_active(new_active: bool) -> void:
	active = new_active
	active_borders.visible = new_active


func on_pick_item(active_hand_type: Enums.HandType, item_code: String) -> void:
	if active_hand_type == hand_type:
		var item_icon = load("res://Assets/Interface/Icons/{code}.png".format({
			"code": item_code
		}))
		icon.texture = item_icon


func on_drop_item(active_hand_type: Enums.HandType) -> void:
	if active_hand_type == hand_type:
		icon.texture = null
