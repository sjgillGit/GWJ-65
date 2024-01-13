extends CharacterBody3D

#--------------------
# Player stats and links to controllers
#--------------------

const SPEED = 5.0
const RUNNING_SPEED = 10.0
const JUMP_VELOCITY = 4.5

var is_running: bool = false

@export
var interface_parent: CanvasLayer
