extends Node

const EnemySwarm = preload("res://scenes/enemy_swarm.tscn")

signal score_changed(new_score)

var score = 0

func get_score() -> int:
	return score
	
func add_score(amount : int) -> void:
	score += amount
	score_changed.emit(score)

func _ready() -> void:
	
	
	trigger_wave()

func trigger_wave() -> void:
	var launch_timer = get_tree().create_timer(Util.circa(3))
	launch_timer.timeout.connect(on_launch_timeout)

	
func launch_wave(target : Vector2) -> void:
	print("LAUNCH AT %s" % target)
	var swarm = EnemySwarm.instantiate()
	
	var view = get_viewport().size
	
	var start = Vector2(Util.rand_plus_minus() * view.x, -view.y)
	var end = Vector2(Util.rand_plus_minus() * view.x, -view.y)
	
	swarm.start_point = start
	swarm.end_point = end

	var mid = (start + end)/2

	swarm.target_point = mid + (target - Vector2(0, 300) - mid) * 2
	
	
	
	get_parent().add_child(swarm)

func on_launch_timeout() -> void:
	launch_wave(get_node("/root/Game/Player").position)
	pass
