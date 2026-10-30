extends Node2D
signal day_finished

@onready var texture: TextureRect = $Texture
@onready var day_timer: Timer = $DayTimer
@onready var rotate_timer: Timer = $RotateTimer

@export var day_length: float = 3
var rotation_increment: float 

func _ready() -> void: 
	day_timer.wait_time = day_length * 60
	rotation_increment = 180.0 / day_timer.wait_time

func start_timer() -> void:
	day_timer.start()
	rotate_timer.start()

func _on_rotate_timer_timeout() -> void:
	if not is_equal_approx(texture.rotation_degrees, 180.0): 
		create_tween().tween_property(texture, "rotation_degrees", texture.rotation_degrees + rotation_increment, 1).set_ease(Tween.EASE_IN_OUT)
	else: 
		day_finished.emit()
		rotate_timer.stop()
		
