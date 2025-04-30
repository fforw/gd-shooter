extends Label

func _ready() -> void:
    Signals.score_changed.connect(on_score_changed)
    
func on_score_changed(score):
    text = "Score: %d" % score
    
