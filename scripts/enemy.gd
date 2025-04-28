class_name Enemy
extends Area2D

@onready var explosion: Node2D = $Explosion

func _ready() -> void:
	pass
	
func hit(power : int) -> void:
	explosion.start()
