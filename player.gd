extends CharacterBody2D

@export var movement_data : PlayerMovementData

var air_jump = false
var just_wall_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_wall_normal = Vector2.ZERO
@onready var label = $CenterContainer/Label


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position
@onready var wall_jump_timer = $WallJumpTimer

@onready var bg_music = $"../BGMusic"
@onready var respawn_sound = $"../RespawnSound"



var coins_count : int = 9

var death_pos = Vector2(-8, 1380)
var level_2_pos = Vector2(670, 1660)
var level_3_pos = Vector2(1220, 1660)
var level_3_5top_pos = Vector2(2110, 1595)
var level_3_5bottom_pos = Vector2(2323, 1885)
var level_4_pos = Vector2(3006, 1750)
var level_5_pos = Vector2(4830, 2075)
var level_5_5pos = Vector2(5530, 2060)
var level_6_pos = Vector2(6880, 2283)
var level_7_pos = Vector2(7720, 2235)

func _physics_process(delta):
	apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	if was_on_wall:
		was_wall_normal = get_wall_normal()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	just_wall_jumped = false
	var just_left_wall = was_on_wall and not is_on_wall()
	if just_left_wall:
		wall_jump_timer.start()
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta
		
func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0: return
	var wall_normal = get_wall_normal()
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
	if Input.is_action_just_pressed("ui_accept"):
		velocity.x = wall_normal.x * movement_data.speed
		velocity.y = movement_data.jump_velocity
		just_wall_jumped = true

func handle_jump():
	if is_on_floor(): air_jump = true

	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = movement_data.jump_velocity
	elif not is_on_floor():
		if Input.is_action_just_released("ui_accept") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2
			
		if Input.is_action_just_pressed("ui_accept") and air_jump and not just_wall_jumped:
			velocity.y = movement_data.jump_velocity * 0.8
			air_jump = false

func handle_acceleration(input_axis, delta):
	if not is_on_floor_only(): return
	if input_axis !=0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis !=0:
			velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_acceleration * delta)
		
func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

	if not is_on_floor():
		animated_sprite_2d.play("jump")


func _on_hazard_detector_area_entered(area):
	global_position = death_pos
	respawn_sound.play()

func _on__hazard_detector_area_entered(area):#da 2nd HazardDetector
	global_position = Vector2(-210, 1740)
	respawn_sound.play()

func _on__h_3_zard_detector_area_entered(area):
	global_position = level_2_pos
	respawn_sound.play()

func _on__h_4_zard_detector_area_entered(area):
	global_position = level_3_pos
	respawn_sound.play()

func _on__h_5_zard_detector_area_entered(area):
	global_position = level_3_5top_pos
	respawn_sound.play()

func _on__h_6_zard_detector_area_entered(area):
	global_position = level_3_5bottom_pos
	respawn_sound.play()

func _on__h_7_zard_detector_area_entered(area):
	global_position = level_4_pos
	respawn_sound.play()

func _on__h_8_zard_detector_area_entered(area):
	global_position = level_5_pos
	respawn_sound.play()

func _on__h_11_zard_detector_area_entered(area):
	global_position = level_5_5pos
	respawn_sound.play()

func _on__h_9_zard_detector_area_entered(area):
	global_position = level_6_pos
	respawn_sound.play()

func _on__h_10_zard_detector_area_entered(area):
	global_position = level_7_pos
	respawn_sound.play()

#func _ready():
	#pass

#func collide_with_coin():
	#if area.is_in_group("Coins"):
		#coin_count -= 1
		#print("coin count: ", collectible_count)

