extends Node2D
@onready var day_complete_label: RichTextLabel = $DayCompleteLabel
@onready var paper_anim: AnimationPlayer = $PaperAnim
@onready var light_anim: AnimationPlayer = $LightAnim
var day : int = 7

func _ready() -> void:
	paper_anim.play("PaperEntrance")
	light_anim.play("LightAnim")
	
	await get_tree().create_timer(1.0).timeout
	
	day_num_roll()

func day_num_roll() -> void:
	var i : int = 0
	while not i == day:
		i += 1
		day_complete_label.text = "DAY " + str(i) + " COMPLETE"
		await get_tree().create_timer(0.1).timeout
