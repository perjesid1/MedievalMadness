extends Node

var settings: Dictionary = {}


func _ready() -> void:
	load_settings()


func save_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var current_section: Dictionary
	for section: Variant in settings.keys():
		if settings[section] is Dictionary:
			current_section = settings[section]
			for key: Variant in current_section.keys():
				config.set_value(str(section), str(key), str(current_section[key]))
		else:
			print("Failed to save settings! Invalid section type.")
	
	var error: Error = config.save("user://settings.cfg")
	if error != OK:
		print("Failed to save settings! Unable to save file.")


func load_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var error: Error = config.load("user://settings.cfg")
	if error != OK:
		print("Failed to load settings!")
	else:
		for section: Variant in config.get_sections():
			settings[section] = {}
			for key: Variant in config.get_section_keys(str(section)):
				settings[section][key] = config.get_value(str(section), str(key))
