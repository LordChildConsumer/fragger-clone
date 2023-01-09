extends Node

##
## TODO: -- Set this to "usr://config.cfg" FOR FINAL BUILD --
##
const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()

var _settings = {
	"controls": {
		"mouse_sens": 0.1
	}
}


func _ready():
	var directory = Directory.new()
	if directory.file_exists(SAVE_PATH):
		load_settings()
	else:
		save_settings()
	print(_settings)


#
# SAVE SETTINGS
#
func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
	
	_config_file.save(SAVE_PATH)


#
# LOAD SETTINGS
#
func load_settings():
	var error = _config_file.load(SAVE_PATH)

	if error != OK:
		print("Error loading settings. Code: %s" % error)
		return []
	
	# Get values
	var values = []
	for section in _settings.keys():
		for key in _settings[section].keys():
			var val = _settings[section][key]
			values.append(_config_file.get_value(section, key, val))
			print("%s: %s" % [key, val])
	
	return values

#
# GET SETTING
#
func get_setting(category, key):
	return _settings[category][key]

#
# SET SETTING
#
func set_setting(category, key, value):
	_settings[category][key] = value
