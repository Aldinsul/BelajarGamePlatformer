extends Node2D
const SAVE_PATH = "res://savegame.bin"


func _on_button_pressed():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data : Dictionary = {
		"PlayerHP": 10,
		"Gold": 0,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	get_tree().change_scene_to_file("res://main.tscn")
