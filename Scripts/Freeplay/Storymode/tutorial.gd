extends Node2D
@onready var serving_customers_base: Node2D = $ServingCustomersBase
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var bg: Control = $BG
@onready var add_bowl: Button = $ServingCustomersBase/Camera2D/CanvasLayer/Control/BowlConts/AddBowl
@onready var food_cont: TextureButton = $FoodCont

var doneBowl = false 
var doneCustomer = false

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(preload("uid://oivqombfgdyo"), "start")
	#playFade(2,1)
	GlobalVars.connect("customerDone", customerDone)

func playFade(goIn, goOut):
	animation_player.play("fade")
	await animation_player.animation_finished
	var bgIn = bg.get_child(goIn)
	var bgOut = bg.get_child(goOut)
	bgIn.position.x = get_viewport().get_visible_rect().size.x
	bgIn.visible = true
	GlobalVars.item_exit(bgOut)
	GlobalVars.item_enter(bgIn)
	await GlobalVars.itemEntered
	bgOut.visible = false
	animation_player.play_backwards("fade")
	if goIn==2:
		serving_customers_base.find_child("CanvasLayer").visible=true
		serving_customers_base.start_day_clock()
		GlobalScenes.story_customers.add_customer_func()
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon(preload("uid://oivqombfgdyo"), "firstCustomer")

func _on_add_bowl_pressed() -> void:
	if not doneBowl:
		DialogueManager.show_dialogue_balloon(preload("uid://oivqombfgdyo"), "clickAddBowl")
		doneBowl = true

func customerDone():
	if not doneCustomer:
		DialogueManager.show_dialogue_balloon(preload("uid://oivqombfgdyo"), "correct")
		GlobalScenes.set_spawn_customers(3, 10)
		doneCustomer = true
		#end
