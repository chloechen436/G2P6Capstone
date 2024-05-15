extends Area2D

@onready var coin_collected_sound = $"../../CoinCollectedSound"

func _on_body_entered(body):
	queue_free()
	var coins = get_tree().get_nodes_in_group("Coins")
	if coins.size() == 1:
		Events.level_completed.emit()
	coin_collected_sound.play()
