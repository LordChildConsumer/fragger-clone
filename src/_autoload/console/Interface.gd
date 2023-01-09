extends CanvasLayer

#
# Signals to connect for debugging
#



onready var _console := $Console;

# Store the tags and colors for the different message types
const colors: Dictionary = {
	# Normal
	0: {
		"start": "[ - ]",
		"end": "",
		"color": Color(0.5, 0.5, 0.5),
		"line-only": true
	},
	# Message with node name
	1: {
		"start": "{",
		"end": "}",
		"color": Color(1, 1, 0),
		"line-only": false
	},
	# Info
	2: {
		"start": "[ I ]",
		"end": "",
		"color": Color(0, 0.75, 0.75),
		"line-only": true
	},
	# Warning
	3: {
		"start": "[ @ ]",
		"end": "",
		"color": Color(1, 0.5, 0),
		"line-only": true
	},
	# Error
	4: {
		"start": "[ !!! ]",
		"end": "",
		"color": Color(1, 0, 0),
		"line-only": true
	}
};

#
# Normal message
#
func say(text: String) -> void:
	_console.output_text("%s%s %s" % [colors[0]["start"], colors[0]["end"], text]);

#
# Message from node
#
func message(node: Object, text: String) -> void:
	_console.output_text("%s%s%s %s" % [colors[1]["start"], node.get_name(), colors[1]["end"], text]);

#
# Info message
#
func info(text: String) -> void:
	_console.output_text("%s%s %s" % [colors[2]["start"], colors[2]["end"], text]);

#
# Warning message
#
func warn(text: String) -> void:
	_console.output_text("%s%s %s" % [colors[3]["start"], colors[3]["end"], text]);

#
# Error message
#
func error(text: String) -> void:
	_console.output_text("%s %s %s" % [colors[4]["start"], colors[4]["end"], text]);

