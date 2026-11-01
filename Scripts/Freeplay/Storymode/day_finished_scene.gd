extends Node2D
@onready var day_complete_label: RichTextLabel = $DayCompleteLabel
@onready var payment: RichTextLabel = $Paper/PerspectiveViewportContainer2D/SubViewport/Payment

@onready var paper_anim: AnimationPlayer = $PaperAnim
@onready var light_anim: AnimationPlayer = $LightAnim
@onready var day_counter_anim: AnimationPlayer = $DayCounterAnim
var day : int = 7

func _ready() -> void:
	paper_anim.play("PaperEntrance")
	light_anim.play("LightAnim")
	await get_tree().create_timer(0.5).timeout
	
	day_counter_anim.play("DayCounterAnim")
	day_num_roll()
	pay_amt_roll()

func day_num_roll() -> void:
	var i : int = 0
	while not i == day:
		i += 1
		day_complete_label.text = "DAY " + str(i) + " COMPLETE"
		await get_tree().create_timer(0.1).timeout

func pay_amt_roll() -> void:
	if GlobalVars.payment <= 0:
		payment.text = "0.0"
		return

	var i : int = 0
	var secs : float = 3.0 / GlobalVars.payment
	while not i == GlobalVars.payment:
		i += 1
		payment.text = str(float(i))
		await get_tree().create_timer(secs).timeout
		secs -= secs/5
	
