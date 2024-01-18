extends CharacterBody3D

#--------------------
# Player stats and links to controllers
#--------------------

class_name Player

const SPEED = 5.0
const RUNNING_SPEED = 10.0
const JUMP_VELOCITY = 4.5

var is_running: bool = false
var may_move: bool = true

@export var interface_parent: CanvasLayer
@export var backpack_items_parent: Node

@onready var hands: HandsController = get_node("HandsController")
@onready var backpack: BackpackController = get_node("BackpackController")
@onready var cloth: ClothController = get_node("ClothController")
@onready var interaction: RayCast3D = get_node("CameraController/Camera/InteractionRay")

func _ready() -> void:
	G.player = self
