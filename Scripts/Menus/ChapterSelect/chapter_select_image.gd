extends TextureRect
@onready var color_rect: ColorRect = $ColorRect2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_anim(): animation_player.play("Fade")
func reverse_anim(): animation_player.play_backwards("Fade")
