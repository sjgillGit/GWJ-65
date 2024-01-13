extends Control

#--------------------
# Interface for hand holding an item
#--------------------

class_name HandButton

@export var hand_type: Enums.HandType
@export var is_active: bool

var active: bool = false
var item_code: ItemBase = null

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


func on_active_hand_switched() -> void:
	set_active(!active)


func set_active(new_active: bool) -> void:
	active = new_active
	active_borders.visible = new_active

