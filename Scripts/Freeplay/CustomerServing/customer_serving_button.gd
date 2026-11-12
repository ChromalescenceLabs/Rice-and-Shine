extends Control
@onready var gradient_anim: AnimationPlayer = $GradientAnim
@onready var arrow_anim: AnimationPlayer = $ArrowAnim

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"): SceneLoader.load_scene("uid://cfbo8eegeu5f0", 1.5)

func _on_color_rect_mouse_entered() -> void:
	gradient_anim.play("GradientFade")
	arrow_anim.play("ArrowAnim")
	await gradient_anim.animation_finished
	set_process_input(true)

func _on_color_rect_mouse_exited() -> void:
	gradient_anim.play_backwards("GradientFade")
	arrow_anim.play_backwards("ArrowAnim")
	set_process_input(false)
