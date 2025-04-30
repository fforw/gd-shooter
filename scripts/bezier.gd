# Implements a bezier curve that supports both random point lookup of positions as well as 
# approximated same-distance-along-curve walking
 
class_name Bezier
extends Node

const MAX_STEP = 20

@export var p0 : Vector2 = Vector2(0,0)
@export var p1 : Vector2 = Vector2(0,0)
@export var p2 : Vector2 = Vector2(0,0)

var t1 : Vector2
var t2 : Vector2

# Evaluates the current bezier curve at the given point t [0...1]
func point_at(t: float) -> Vector2:
    var q0 = p0.lerp(p1, t)
    var q1 = p1.lerp(p2, t)
    var r = q0.lerp(q1, t)
    return r
    
# Estimates the next curve position t' from the given position t and a target
# distance to walk along the bezier curve
func walk(t: float, len: float) -> float:
    
    if not (t1 and t2):
        #  v⃗ 1=2A−4B+2C and v⃗ 2=−2A+2B
        t1 = 2 * p0 - 4 * p1 + 2 * p2
        t2 = -2 * p0 + 2 * p1

    while len > 0:
            
        t += (min(len, MAX_STEP) / (t * t1 + t2).length())
        
        len -= MAX_STEP
        
    return t
    
