extends Node

const EnemySwarm = preload("res://scenes/enemy_swarm.tscn")

var game : Game 

var score = 0

func _registerGame(g) -> void:
    game = g

func get_score() -> int:
    return score
    
func add_score(amount : int) -> void:
    score += amount
    Signals.score_changed.emit(score)

func _ready() -> void:
    trigger_wave()

func trigger_wave() -> void:
    var launch_timer = get_tree().create_timer(RNG.circa(3))
    launch_timer.timeout.connect(on_launch_timeout)
    
func launch_wave(target : Vector2) -> void:
    print("LAUNCH AT %s" % target)
    var swarm = EnemySwarm.instantiate()
    
    var view = get_viewport().size
    
    var start = Vector2(RNG.plus_minus() * view.x * 1.25, -view.y * 1.15)
    var end = Vector2(RNG.plus_minus() * view.x * 1.25, -view.y * 1.15)
    
    swarm.position = start
    swarm.start_point = start
    swarm.end_point = end

    var mid = (start + end)/2

    swarm.target_point = mid + (target - mid) * 1.6

    game.add_child(swarm)

func on_launch_timeout() -> void:
    launch_wave(get_node("/root/Game/Player").position)
    pass
