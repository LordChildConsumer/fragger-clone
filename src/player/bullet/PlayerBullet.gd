class_name PlayerBullet extends RigidBody2D;

signal bullet_exploded(bullet);

const EXPLOSION_FORCE := 1000.0;

### Node References ###
onready var _sprite := $Sprite;
onready var _bound_snd := $BounceSND;
onready var _explosion := $ExplosionRadius;

### Variables ###
var sprite_dir := Vector2();

var colliding: bool;
var last_collider

func _physics_process(delta: float) -> void:
	sprite_dir = lerp(sprite_dir, linear_velocity, 0.25);
	
	_sprite.look_at(global_position + sprite_dir);


#
# Play a sound when the bullet bounces
#
func _on_PlayerBullet_body_entered(body: Node) -> void:
	if body is Enemy:
		body.call_deferred("kill");
		emit_signal("bullet_exploded", self);
	
	elif body != last_collider && !colliding:
		colliding = true;
		last_collider = body;
		_bound_snd.play();

func _on_BounceRadius_body_exited(body: Node) -> void:
	colliding = false;

#
# Explode after a certain amount of time
#
func _on_Lifetime_timeout() -> void:
	var bodies: Array = _explosion.get_overlapping_bodies();
	bodies.erase(self);
	
	for body in bodies:
		if body is Enemy:
			body.call_deferred("kill");
		elif body is RigidBody2D:
			body.apply_central_impulse(
				global_position.direction_to(body.global_position) * EXPLOSION_FORCE
			)
	
	emit_signal("bullet_exploded", self)
