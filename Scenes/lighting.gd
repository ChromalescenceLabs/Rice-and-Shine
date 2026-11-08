extends CanvasModulate

const MINUTES_PER_DAY = 300 #number of seconds in those minutes
const MINUTES_PER_HOUR = 60 #number of minutes
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

var time: float = 0.0
@export var gradient: GradientTexture1D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	time += delta
	var value = (sin(time - PI /2) + 1.0) /2.0
	self.color = gradient.gradient.sample(value)
	_recalculate_time()

func _recalculate_time() -> void:
	var total_mins = int(time / INGAME_TO_REAL_MINUTE_DURATION)
