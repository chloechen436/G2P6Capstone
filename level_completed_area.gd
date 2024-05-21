extends Area2D

@onready var level_comp_sound = $"../LevelCompSound"

func _on_body_entered(body):
	queue_free()
	level_comp_sound.play()
