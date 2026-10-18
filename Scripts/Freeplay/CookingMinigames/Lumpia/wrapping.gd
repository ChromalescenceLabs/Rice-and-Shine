extends Node2D
signal wrap_filled
const WRAP = preload("uid://dcwdlqnrugjlk")
@onready var bowl_texture: TextureRect = $BowlArea/BowlTexture
@onready var wrap_sprite: Wrap = $Wrap
var wrap_ogpos : Vector2
var hovering_bowl : bool = false

var wrapped_qty : int = 0

func _ready() -> void:
	wrap_ogpos = wrap_sprite.global_position
	wrap_sprite.wrap_finished.connect(_on_wrap_finished)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click") and hovering_bowl and not wrap_sprite.allow_wrapping:
		var lumpia_wrap = WRAP.instantiate()
		add_child(lumpia_wrap)

func _on_bowl_texture_mouse_entered() -> void: hovering_bowl = true
func _on_bowl_texture_mouse_exited() -> void: hovering_bowl = false

func _on_wrap_filled() -> void:
	wrap_sprite.allow_wrapping = true
	

func _on_wrap_finished() -> void:
	wrapped_qty += 1
	
	if wrapped_qty >= 3:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		get_tree().current_scene.wrapping_finished.emit()
	else:
		var lumpia_wrap = WRAP.instantiate()
		lumpia_wrap.global_position = wrap_ogpos
		add_child(lumpia_wrap)
		
