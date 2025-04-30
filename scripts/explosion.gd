class_name Explosion
extends Node2D
@onready var explosion_particles: GPUParticles2D = $ExplosionParticles
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound

signal done
        
func explode() -> Signal:
    explosion_particles.emitting = true
    explosion_sound.play()
    return done
    
func _on_explosion_sound_finished() -> void:
    explosion_particles.emitting = false
    done.emit()
