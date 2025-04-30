class_name EnemySwarm
extends Node2D

const Enemy = preload("res://scenes/enemy.tscn")

@export var count : int = 3
@export var curve_pos : float = 0
@export var start_point : Vector2 = Vector2(0,0)
@export var end_point : Vector2 = Vector2(0,0)
@export var target_point : Vector2 = Vector2(0,0)

var curve: Bezier
var enemies : Array[Enemy]
var done : bool = false

func _ready() -> void:

    # setup curve
    curve = Bezier.new()
    curve.p0 = start_point
    curve.p1 = target_point
    curve.p2 = end_point
    curve_pos = 0

    var step = (2 * PI) / count
    var angle = 0
    
    
    for i in range(count):    
        #print("CREATE ENEMY: %s, %s" % [i, angle])

        var enemy : Enemy = Enemy.instantiate()
        enemy.offset = Vector2(cos(angle) * 75, sin(angle) * 75)    
        enemy.position = position + enemy.offset
        enemy.id = i
        enemy.swarm = self
        Global.game.add_child(enemy)

        enemies.append(enemy)
        angle += step

    
func _process(delta: float) -> void:

    position = curve.point_at(curve_pos)
    curve_pos = curve.walk(curve_pos, 250 * delta)
    if curve_pos >= 1:
        print("wave done")
        Global.trigger_wave()
        queue_free()
        for e in enemies:
            if e:
                e.queue_free()
        done = true
