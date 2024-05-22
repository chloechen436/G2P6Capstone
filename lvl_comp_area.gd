extends Area2D

@onready var lvl_comp_sound = $"../LvlCompSound"

func _on_body_entered(body):
	queue_free()
	lvl_comp_sound.play()
