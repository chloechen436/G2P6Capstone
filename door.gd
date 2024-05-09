extends StaticBody2D

@export var linked_coins : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_check_area_body_entered(body):
	print("collisio with: " + body.name)
	print("checking all coins")
	if are_coins_collected():
		print("no coins found, destorying door")
		#if all the coins are collected, destroy this door.
		destroy_door()
	pass # Replace with function body.
	
#Checks whether all the coins are collected
func are_coins_collected():
	for coin in linked_coins:
		if coin != null:
			print("coin " + coin.name + "is not null")
			return false
	print("no coins found")
	return true

#destroy the door
func destroy_door():
	self.queue_free()
