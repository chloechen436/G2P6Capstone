extends CanvasLayer

class_name UI

@onready var coins_left_label = %CoinsLeftLabel

func set_coins_left(coins_left: int):
	coins_left_label.text = "Coins Left: %d" % coins_left
