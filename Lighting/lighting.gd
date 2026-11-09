extends CanvasModulate

const MINUTES_PER_DAY = 1440 #number of seconds in those minutes
const MINUTES_PER_HOUR = 60 #number of minutes


signal time_tick(day:int, hour:int, min:int)


var time: float = 0.0
var past_min: int = -1.0

@export var REAL_SECONDS_PER_DAY: float = 300.0
@export var gradient: GradientTexture1D
@export var INGAME_SPEED = 1.0
@export var INITIAL_HR = 8

func _ready() -> void:
	add_to_group("day_night_cycle")
	var initial_total_mins = INITIAL_HR * MINUTES_PER_HOUR
	var day_ratio = initial_total_mins / float(MINUTES_PER_DAY)
	time = day_ratio * REAL_SECONDS_PER_DAY
	
func _process(delta: float) -> void:
	time += delta * INGAME_SPEED
	if time >= REAL_SECONDS_PER_DAY:
		time -= REAL_SECONDS_PER_DAY
	var day_progress = time / REAL_SECONDS_PER_DAY
	var value = (sin((day_progress * 2.0 * PI) - PI / 2.0) + 1.0) / 2.0
	
	if gradient and gradient.gradient:
		self.color = gradient.gradient.sample(value)

	_recalculate_time()

func _recalculate_time() -> void:
	var day_progress = time / REAL_SECONDS_PER_DAY
	var total_mins = int(day_progress * MINUTES_PER_DAY)

	var hour = int(total_mins / MINUTES_PER_HOUR)
	var min = int(total_mins % MINUTES_PER_HOUR)
	var day = 0
	
	if past_min != min:
		past_min = min
		time_tick.emit(day,hour,min)
	
