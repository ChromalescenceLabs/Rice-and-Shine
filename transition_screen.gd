extends CanvasLayer

signal on_trans_fin
@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_anim_fin)

func _on_anim_fin(anim_name):
	if anim_name =="fade_in":
		on_trans_fin.emit()
		anim_player.play ("fade_out")
	elif anim_name == "fade out":
		color_rect.visible = false

func transition():
	color_rect.visible = true
	anim_player.play("fade_in")
	
