extends Area2D
@onready var bullet_timer: Timer = $Timer
@onready var laser_sound: AudioStreamPlayer2D = $LaserSound
@onready var score_label: Label = $ScoreLabel

@export var power : float = 100
@export var bullet_speed : float = 1000
@export var direction : Vector2 = Vector2.UP


func _ready() -> void:
    laser_sound.pitch_scale = RNG.circa(1)
    laser_sound.play()
    bullet_timer.wait_time = 2
    bullet_timer.start()	
    
func _physics_process(delta: float) -> void:
    position += direction * bullet_speed * delta
    
func _on_timer_timeout() -> void:
    queue_free()

func _on_area_entered(area: Area2D) -> void:
    
    if area is Enemy:
        Global.add_score(10)
        area.hit(power)
        queue_free()
