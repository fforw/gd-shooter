extends Node2D

const Enemy = preload("res://scenes/enemy.tscn")

const MAX_LIFE = 12

@export var count : int = 3
@export var start_point : Vector2 = Vector2(0,0)
@export var end_point : Vector2 = Vector2(0,0)
@export var target_point : Vector2 = Vector2(0,0)
@export var life_time : float = MAX_LIFE

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r

func _ready() -> void:
	position.y = -get_viewport().size.y
	pass
		
func _process(delta: float) -> void:
	life_time -= delta
	if life_time < 0:
		print("wave done")
		Global.trigger_wave()
		queue_free()
		return
	
	var t = (MAX_LIFE - life_time) / MAX_LIFE		
	
	position = _quadratic_bezier(
		start_point,
		target_point,
		end_point,
		t
	)
