extends HBoxContainer
signal upset(node : TextureButton)
@onready var icon: TextureRect = $Icon
@onready var bar: ProgressBar = $Bar
@onready var timer: Timer = $Timer
var type : String
var associated_node : TextureButton

var info = []

func _ready() -> void:
	if not GlobalScenes.add_customer.is_connected(start_timer):
		GlobalScenes.add_customer.connect(start_timer)
	
func start_timer():
	GlobalScenes.add_customer.disconnect(start_timer)
	timer.start()

func _on_timer_timeout() -> void: bar.value -= 1

func _on_bar_value_changed(value: float) -> void:
	if value <= 0:
		upset.emit(associated_node)
		self.queue_free()
	
