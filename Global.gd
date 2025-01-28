extends Node
## Autoload Singleton for handling global functions and variables.


## Path to the settings file.
const SETTINGS_PATH: String = "user://settings.cfg"


## Contains the settings for the game.
## Each setting group is Dictionary, where the keys are the settings' names.
var settings: Dictionary = {}
## True when the game loads for the first time, then set to false.
## Used to determine the starting point for the theme song of the main menu.
var first_load: bool = true


func _ready() -> void:
	load_settings()


## Saves the contents of the "settings" Dictionary to the settings file to the path defined in the SETTINGS_PATH constant.
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
	
	var error: Error = config.save(SETTINGS_PATH)
	if error != OK:
		print("Failed to save settings! Unable to save file.")

## Loads the settings file from the path defined in the SETTINGS_PATH constant.
## The settings will be accessible through this classes "settings" Dictionary.
func load_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var error: Error = config.load(SETTINGS_PATH)
	if error != OK:
		print("Failed to load settings!")
	else:
		for section: Variant in config.get_sections():
			settings[section] = {}
			for key: Variant in config.get_section_keys(str(section)):
				settings[section][key] = config.get_value(str(section), str(key))
