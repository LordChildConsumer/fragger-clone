extends Area2D


func _ready() -> void:
	yield(get_tree(), "idle_frame");
	
	connect("body_shape_entered", self, "_body_entered");
	
#	print(get_overlapping_bodies());
#	print(get_overlapping_areas());

func _body_entered(body) -> void:
	print("entered")
