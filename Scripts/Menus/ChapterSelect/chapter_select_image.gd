@tool
extends TextureRect

@export var ChapSelectImg : Texture2D:
	set(value):
		ChapSelectImg = value
		#_set_properties()

@onready var color_rect: ColorRect = $ColorRect2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void: _set_properties()

func play_anim(): animation_player.play("Fade")
func reverse_anim(): animation_player.play_backwards("Fade")
		
func _set_properties() -> void: texture_rect.texture = ChapSelectImg
