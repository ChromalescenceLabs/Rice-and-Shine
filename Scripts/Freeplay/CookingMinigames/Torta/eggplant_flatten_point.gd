extends PointLight2D
@onready var success_particles: GPUParticles2D = $SuccessParticles
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_area: TextureRect = $HoverArea

func _ready() -> void:
	set_process_input(false)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		animation_player.play("HeldDown")
	elif event.is_action_released("Click"):
		animation_player.pause()

func _on_hover_area_mouse_entered() -> void: 
	set_process_input(true)
func _on_hover_area_mouse_exited() -> void: 
	set_process_input(false)
	animation_player.pause()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "HeldDown":
		success_particles.emitting = true
		get_parent().get_parent().flattened_points += 1
		hover_area.mouse_filter = Control.MOUSE_FILTER_IGNORE
