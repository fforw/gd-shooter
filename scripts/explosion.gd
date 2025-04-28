extends Node2D
@onready var explosion_particles: GPUParticles2D = $ExplosionParticles
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound

signal done

func _ready() -> void:
	explosion_sound.finished.connect(on_explosion_sound_finished)
	
func on_explosion_sound_finished() -> void:
	explosion_particles.emitting = false
	get_parent().queue_free()
	done.emit()
	
func start() -> void:
	explosion_particles.emitting = true
	explosion_sound.play()
	
