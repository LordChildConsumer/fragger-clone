extends KinematicBody2D

signal fire_projectile(pos, dir, force);


### Node References ###
onready var gun := $Gun;
onready var muzzle := $Gun/Muzzle;
onready var shot_power := $Gun/Power;
onready var shoot_fx := $Gun/ShootFX;
onready var shoot_snd := $Gun/ShootSND;


### Variables ###
var can_shoot: bool = true setget set_can_shoot;

### Ready ###
func _ready() -> void:
	get_parent().player = self; ## Give the level a reference to the player

### Process ###
func _process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position();
	
	gun.look_at(mouse_pos);
	shot_power.value = muzzle.global_position.distance_to(mouse_pos) / 4;

### Input ###
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene();
	
	if Input.is_action_just_pressed("player_shoot") && can_shoot:
		set_can_shoot(false);
		shoot_fx.set_emitting(true);
		shoot_snd.play();
		emit_signal(
			"fire_projectile",
			muzzle.global_position,
			muzzle.global_position.direction_to(get_global_mouse_position()),
			shot_power.value * 1.5
		);

func set_can_shoot(value: bool) -> void:
	can_shoot = value;
	shot_power.set_visible(value);
