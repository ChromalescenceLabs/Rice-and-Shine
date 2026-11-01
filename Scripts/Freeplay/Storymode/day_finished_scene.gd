extends Node2D
@onready var paper_anim: AnimationPlayer = $PaperAnim
@onready var light_anim: AnimationPlayer = $LightAnim

func _ready() -> void:
	paper_anim.play("PaperEntrance")
	light_anim.play("LightAnim")
