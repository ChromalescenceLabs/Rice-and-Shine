extends TextureButton
@onready var parallax_cam: Camera2D = $"../../../CanvasLayer/ParallaxCam"
@onready var zoom_cam: Camera2D = $"../../../CanvasLayer/ZoomCam"
@onready var animation_player: AnimationPlayer = $"../../../CanvasLayer/ZoomCam/AnimationPlayer"
const OPEN_WINDOW_STORY = preload("uid://bvg8xwug7hye5")
@onready var node_2d: Node2D = $"../.."

func _on_pressed() -> void: 
	for i in node_2d.get_children():
		if i is Parallax2D:
			i.scroll_scale = Vector2(1.0,1.0)
			
	parallax_cam.enabled = false
	zoom_cam.enabled = true
	animation_player.play("zoom_story")
	texture_normal = OPEN_WINDOW_STORY
	await animation_player.animation_finished
	SceneLoader.load_scene("uid://f5bkmxvr0cpx", 2)
