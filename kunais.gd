extends Area2D

@onready var weapon_pickup_sound = $"../WeaponPickupSound"

func _on_body_entered(body):
	queue_free()
	weapon_pickup_sound.play()
