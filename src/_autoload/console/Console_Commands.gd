extends Node

#
# Command Argument Types
#
enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}


#
# Valid Commands
#
const valid_commands = [
	#["command", [ARG_TYPE, ARG_TYPE],
	["help", [], "Shows the full list of commands"],
	["clear", [], "Clears the console"],
	["write", [ARG_STRING], "Writes to this window"]
];


#########################
### Command Functions ###
#########################

func write(text) -> String:
	return text;

#
# Help
#
func help() -> String:
	var help_list: String = "Command List\n\n";
	for c in valid_commands:
		help_list += "%s | %s\n" % [c[0], c[2]];
	
	return help_list

#
# Clear
#
func clear() -> void:
	get_parent().output_box.text = "";
	get_parent().process_command("help");
