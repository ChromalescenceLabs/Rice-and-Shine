extends Control

@export var rice_counter: RichTextLabel 
@export var pcake_counter: RichTextLabel
@export var hbrown_counter: RichTextLabel 
@onready var rice_cont: TextureButton = $"../ScrollContainer/FoodConts/RiceCont"
@onready var pancake_cont: TextureButton = $"../ScrollContainer/FoodConts/PancakeCont"
@onready var hashbrown_cont: TextureButton = $"../ScrollContainer/FoodConts/HashbrownCont"

var rice_og_pos
var pcake_og_pos
var hbrown_og_pos

func _ready() -> void:
	await get_tree().physics_frame
	
	rice_og_pos = rice_cont.global_position.y
	pcake_og_pos = pancake_cont.global_position.y
	hbrown_og_pos = hashbrown_cont.global_position.y
	
func _process(_delta: float) -> void:
	rice_counter.global_position.x = rice_cont.global_position.x + rice_cont.size.x/2 - rice_counter.size.x/2
	pcake_counter.global_position.x = pancake_cont.global_position.x + pancake_cont.size.x/2 - pcake_counter.size.x/2
	hbrown_counter.global_position.x = hashbrown_cont.global_position.x + hashbrown_cont.size.x/2 - hbrown_counter.size.x/2
	
func _on_rice_cont_mouse_entered() -> void: enter(rice_og_pos, rice_counter)
func _on_rice_cont_mouse_exited() -> void: exit(rice_og_pos, rice_counter)

func _on_pancake_cont_mouse_entered() -> void: enter(pcake_og_pos, pcake_counter)
func _on_pancake_cont_mouse_exited() -> void: exit(pcake_og_pos, pcake_counter)

func _on_hashbrown_cont_mouse_entered() -> void: enter(hbrown_og_pos, hbrown_counter)
func _on_hashbrown_cont_mouse_exited() -> void: exit(hbrown_og_pos, hbrown_counter)
	
func enter(ogpos_value, counter):
	create_tween().tween_property(counter, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(counter, "position:y", ogpos_value - 20, 0.2).set_trans(Tween.TRANS_SINE)
	
func exit(ogpos_value, counter):
	create_tween().tween_property(counter, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(counter, "position:y", ogpos_value + 20, 0.2).set_trans(Tween.TRANS_SINE)
