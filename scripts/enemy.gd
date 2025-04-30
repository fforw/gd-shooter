class_name Enemy
extends Area2D

const THRUST = 1000
const DISTANCE_OTHERS = 150

@onready var explosion: Explosion = $Explosion

@export var id : float = 0
@export var velocity : Vector2 = Vector2(0,0)
@export var offset : Vector2 = Vector2(0,0)

var swarm : EnemySwarm

func _ready() -> void:
    print("Enemy ready at %s, offset = %s" % [position, offset])
    
func accelerate(v) -> void:
    velocity += v

func _process(delta: float) -> void:
    position += velocity * delta
    
    if swarm.done:
        return

    var min
    var closest     
    
    var enemies = swarm.enemies

    min = INF
    closest = null
    for other in enemies:
        if other and not other.is_queued_for_deletion() and other.id != id:
            var distance = (position - other.position).length()
            if distance < min:
                min = distance
                closest = other
    
    if min < DISTANCE_OTHERS:            
        var d = (closest.position - position)/min            
        var acc = d * THRUST * 0.02 * (1 - (min/DISTANCE_OTHERS))
        # print("Separating %s and %s at %s" % [enemy, closest, acc])
        accelerate(-acc)

    var diff = (swarm.position + offset) - position
    var distance = diff.length()       
    if distance != 0: 
        diff /= distance
    else:
        var a = RNG.plus_minus() * PI
        diff = Vector2(cos(a),sin(a))
    
    var f = THRUST * distance * 0.000015
    var acc = diff * f 
    # print("Follow center at %s" % acc)
    accelerate(acc)
    

    
func hit(power : int) -> void:
    await explosion.explode()
    queue_free()	
    
