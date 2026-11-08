extends Node2D
@onready var serving_customers_base: Node2D = $ServingCustomersBase
@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var bg: Control = $BG

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(preload("uid://oivqombfgdyo"))
	#serving_customers_base.start_day_clock()
	#GlobalScenes.set_spawn_customers(3, 10)

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
