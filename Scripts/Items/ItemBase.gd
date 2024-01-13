extends Node

#--------------------
# Base class for items
#--------------------

class_name ItemBase

@export
var item_code: String


func get_item_name() -> String: 
	return Lang.get_item_data(item_code).name


func use() -> void:
	print("item is used!")
