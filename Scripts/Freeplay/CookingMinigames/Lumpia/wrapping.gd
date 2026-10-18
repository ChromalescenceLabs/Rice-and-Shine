extends Node2D
signal wrap_filled
const WRAP = preload("uid://dcwdlqnrugjlk")
const LUMPIA_MIX = preload("uid://5kvadyfw4eb")
@onready var bowl_texture: TextureRect = $BowlArea/BowlTexture
@onready var wrap_sprite: Wrap = $Wrap
var wrap_ogpos : Vector2
var hovering_bowl : bool = false
@onready var wrapping: Node2D = $"."

var wrapped_qty : int = 0

func _ready() -> void:
	wrap_ogpos = wrap_sprite.global_position
	wrapping.get_children()[1].wrap_finished.connect(_on_wrap_finished)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click") and hovering_bowl and not wrapping.get_children()[1].allow_wrapping:
		var lumpia_wrap = LUMPIA_MIX.instantiate()
		lumpia_wrap.global_position = get_global_mouse_position()
		add_child(lumpia_wrap)

func _on_bowl_texture_mouse_entered() -> void: hovering_bowl = true
func _on_bowl_texture_mouse_exited() -> void: hovering_bowl = false

func _on_wrap_filled() -> void:
	wrapping.get_children()[1].allow_wrapping = true
	

func _on_wrap_finished() -> void:
	wrapped_qty += 1
	
	if wrapped_qty >= 3:
		get_tree().current_scene.wrapping_finished.emit()
	else:
		var lumpia_wrap = WRAP.instantiate()
		lumpia_wrap.global_position = wrap_ogpos
		lumpia_wrap.position.x += get_viewport().get_visible_rect().size.x
		add_child(lumpia_wrap)
		GlobalVars.indiv_item_enter(lumpia_wrap, wrap_ogpos)
		lumpia_wrap.wrap_finished.connect(_on_wrap_finished)
