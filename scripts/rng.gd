extends Node

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
    set_random_seed()

func set_random_seed() -> void:	
    # since this is seeding the new PRNG, this is the only location where we use
    # a normal, non-reproducible random
    set_seed(randf() * 0xffffffff)
        
func set_seed(seed : int) -> void:
    rng.seed = seed
    
func random() -> float:
    return rng.randf()

func shaped_random(power) -> float:
    return pow(rng.randf(), power)

func plus_minus() -> float:
    return (-0.5 + rng.randf()) * 2

func circa(n : float, variance =  0.15) -> float:
    var factor = ((1 - variance) + 2 * variance * rng.randf())
    return n * factor
