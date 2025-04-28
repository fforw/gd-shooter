class_name Util
extends Node

static func rand_plus_minus() -> float:
	return (-0.5 + randf()) * 2

static func circa(n : float) -> float:
	return (0.85 +  0.3 * randf()) * n
	
