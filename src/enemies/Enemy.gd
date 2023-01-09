class_name Enemy extends RigidBody2D;

signal enemy_killed(enemy);

func kill() -> void:
	emit_signal("enemy_killed", self);
