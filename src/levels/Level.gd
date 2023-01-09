class_name Level extends Node2D;

### Variables ###
onready var player: Node2D;

### Scene Preloads ###
onready var player_bullet := preload("res://src/player/bullet/PlayerBullet.tscn");
onready var explosion := preload("res://src/player/bullet/Explosion.tscn");
onready var kill_effect := preload("res://src/enemies/KillEffect.tscn");


func _ready() -> void:
	## Connect the player's shooting signal to self.
	if player:
		player.connect("fire_projectile", self, "fire_projectile");
	
	for enemy in $Enemies.get_children():
		enemy.connect("enemy_killed", self, "enemy_killed")

#
# Spawn the bullet
#
func fire_projectile(pos, dir, force) -> void:
	var new_proj := player_bullet.instance();
	add_child(new_proj);
	
	new_proj.set_global_position(pos);
	new_proj.apply_central_impulse(dir * (force * 10));
	
	new_proj.connect("bullet_exploded", self, "bullet_exploded");

#
# Explode the bullet
#
func bullet_exploded(bullet) -> void:
	bullet.disconnect("bullet_exploded", self, "bullet_exploded");
	
	## Add the explosion
	var new_explosion := explosion.instance();
	add_child(new_explosion);
	new_explosion.set_global_position(bullet.global_position);
	
	player.set_can_shoot(true);
	bullet.queue_free();

#
# Handle enemy deaths
#
func enemy_killed(enemy) -> void:
	var new_kill_fx := kill_effect.instance();
	
	add_child(new_kill_fx);
	new_kill_fx.set_global_position(enemy.global_position);
	
	enemy.disconnect("enemy_killed", self, "enemy_killed");
	enemy.queue_free();
