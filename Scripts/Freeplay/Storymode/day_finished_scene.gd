extends Node2D
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")

@onready var day_complete_label: RichTextLabel = $InitialScreen/DayCompleteLabel
@onready var payment: RichTextLabel = $InitialScreen/Paper/PerspectiveViewportContainer2D/SubViewport/Payment

@onready var paper_light: PointLight2D = $InitialScreen/PaperLight
@onready var paper_anim: AnimationPlayer = $InitialScreen/PaperAnim
@onready var light_anim: AnimationPlayer = $InitialScreen/LightAnim
@onready var day_counter_anim: AnimationPlayer = $InitialScreen/DayCounterAnim

@onready var payment_bg_anim_anim: AnimationPlayer = $InitialScreen/PaymentBGAnimAnim
@onready var payment_bg_light: TextureRect = $ContinuedScreen/PaymentBGLight

@onready var second_paper_anim: AnimationPlayer = $ContinuedScreen/SecondPaperAnim
@onready var paper: ColorRect = $ContinuedScreen/Paper
@onready var payment2: RichTextLabel = $ContinuedScreen/Paper/Payment
@onready var continue_btn: Button = $ContinuedScreen/Continue

var day : int = GlobalVars.day

func _ready() -> void:
	payment2.text = str(GlobalVars.payment)
	paper_anim.play("PaperEntrance")
	light_anim.play("LightAnim")
	await get_tree().create_timer(0.5).timeout
	
	day_counter_anim.play("DayCounterAnim")
	day_num_roll()
	await pay_amt_roll()
	
	await get_tree().create_timer(2).timeout
	
	light_anim.play_backwards("LightAnim")
	payment_bg_anim_anim.play("PaymentBGAnim")
	second_paper_anim.play("SecondPaperEnter")
	
	await second_paper_anim.animation_finished
	var tw = create_tween().tween_property(continue_btn, "modulate:a", 1, 1.0).set_trans(Tween.TRANS_CUBIC)
	await tw.finished
	
	continue_btn.mouse_filter = Control.MOUSE_FILTER_STOP

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
	
	return

func _on_continue_pressed() -> void: SceneLoader.load_scene("uid://ioxwjdwyns2e", 1.5, LOADING_SCREEN_FADE)
