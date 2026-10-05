extends Node2D
@onready var pepper_shaker: TextureRect = $PepperShaker
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pepper_shake_area: Area2D = $PepperShakeArea
@onready var pepper_shake_col: CollisionShape2D = $PepperShakeArea/CollisionShape2D
@onready var pepper: GPUParticles2D = $PepperShaker/Pepper

var og_pos
var dragging: bool = false
var draggable: bool = false
var went_in: bool = false

func _process(_delta: float) -> void:
	if dragging: pepper_shaker.global_position = lerp(pepper_shaker.global_position, get_global_mouse_position() + Vector2(0 - 90, 0 - 200), 0.2)
	pepper_shake_col.global_position.x = pepper_shaker.global_position.x + pepper_shaker.size.x/4 - 10
	pepper_shake_col.global_position.y = pepper_shaker.global_position.y + pepper_shaker.size.y/2 + 40
	pepper.global_position.x = pepper_shaker.global_position.x + pepper_shaker.size.x/4 - 10
	pepper.global_position.y = pepper_shaker.global_position.y + pepper_shaker.size.y/2 + 20

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if draggable: 
			dragging = true
	if event.is_action_released("Click"):
		if dragging:
			dragging = false
			pepper_shaker.position = og_pos
	if event.is_action_pressed("Pour"):
		if dragging:
			animation_player.play("shake")
			pepper_shake_area.monitorable = false
			pepper_shake_area.monitoring = false
			pepper.emitting = true
			await animation_player.animation_finished
			pepper_shake_area.monitorable = true
			pepper_shake_area.monitoring = true
			went_in = false
			pepper.emitting = false

func _on_pepper_shaker_mouse_entered() -> void: draggable = true
func _on_pepper_shaker_mouse_exited() -> void: draggable = false

func _on_inihaw_shake_start() -> void: 
	og_pos = pepper_shaker.position

func _on_pepper_shake_area_area_entered(area: Area2D) -> void:
	if area is BowlFillArea and not went_in:
		went_in = true
		get_tree().current_scene.shakes += 1
		

func _on_pepper_shake_area_area_exited(area: Area2D) -> void:
	if area is BowlFillArea:
		pass
