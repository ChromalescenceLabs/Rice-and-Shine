@tool
extends TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var bg_texture : Texture2D = preload("uid://b4lajgqgw3lqx"):
	set(value):
		bg_texture = value
		_update_properties()

func select() -> void:
	self.move_to_front()
	animation_player.play("enter_exit")

func _update_properties() -> void:
	self.texture = bg_texture
