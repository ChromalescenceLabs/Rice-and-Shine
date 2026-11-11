@tool
extends ColorRect
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var ChapSelectImg : Texture2D:
	set(value):
		ChapSelectImg = value
		_set_properties()
		
func _set_properties() -> void:
	texture_rect.texture = ChapSelectImg

func play_anim(): animation_player.play("fade")
func reverse_anim(): animation_player.play_backwards("fade")
