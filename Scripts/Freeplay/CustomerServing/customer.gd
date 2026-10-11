extends TextureButton

var customer = load("uid://bivmd1klxx532")

var final_pos
var indx : int
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	initialization()

func initialization() -> bool:
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	if data == null:
		self.modulate.a = 1.0
		animation_player.play("enter_exit")
			
	return true

func _on_pressed() -> void:
	var something = DialogueManager.show_dialogue_balloon(customer, "student")
	something.global_position = self.global_position
	something.indx = indx
