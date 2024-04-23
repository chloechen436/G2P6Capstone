extends Area2D

func _on_area_entered(area):
	if area.is_in_group("Player"):
		print("collided with player")
