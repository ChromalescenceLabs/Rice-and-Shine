extends Node2D
signal day_finished

@onready var texture: TextureRect = $ClockTextureContainer/ClockTexture
@onready var day_timer: Timer = $DayTimer
@onready var rotate_timer: Timer = $RotateTimer
@onready var time_label: RichTextLabel = $TimeLabel

@export var day_length: float = 10
var day_seconds : int
var rotation_increment: float 

func _ready() -> void: 
	time_label.text = "07:00 AM"
	day_seconds = 7 * 60
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
		
	day_seconds += 1
	@warning_ignore("integer_division")
	var mins = int(day_seconds) / 60
	var secs = int(day_seconds) % 60
	
	time_label.text = "%02d:%02d" % [mins, secs]
	
	if day_seconds >= 12 * 60: time_label.text = time_label.text + " PM"
	else: time_label.text = time_label.text + " AM"
	
	rotate_timer.start()
	

func _on_day_timer_timeout() -> void: day_finished.emit()
