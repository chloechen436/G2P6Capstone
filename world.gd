extends Node2D

@export var next_level: PackedScene


@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var hearts_collected = $CanvasLayer/HeartsCollected

func _ready():
	Events.level_completed.connect(show_level_completed)
	Events.hearts_collected.connect(show_hearts_collected)
	
func show_hearts_collected():
	hearts_collected.show()
	
func show_level_completed():
	level_completed.show()
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	if not next_level is PackedScene: return
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
