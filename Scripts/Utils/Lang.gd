extends Node

class_name Lang

static var current_lang_code: Enums.LangCode = Enums.LangCode.En


static func get_item_data(code: String) -> Dictionary:
	var data = Lang.read_json_file("res://Assets/Lang/{lang}/items.json".format(
		{ "lang": get_lang_code()}
	))
	
	return data[code]


static func get_trans(code: String, file: String) -> String:
	var data = Lang.read_json_file("res://Assets/Lang/{lang}/{file}.json".format(
		{
			"lang": get_lang_code(),
			"file": file
		}
	))
	
	return data[code]


static func get_lang_code() -> String:
	return Enums.LangCode.keys()[current_lang_code]


static func read_json_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	return JSON.parse_string(content_as_text)
