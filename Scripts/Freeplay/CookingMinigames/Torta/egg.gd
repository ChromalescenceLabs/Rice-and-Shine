extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_velocity
var cracked : bool = false
var touched_bowl : bool = false
@onready var egg_insides: Sprite2D = $EggInsides

@onready var egg_normal: TextureRect = $EggTextures/EggNormal
@onready var egg_crack: TextureRect = $EggTextures/EggCrack
@onready var egg_crack_b: TextureRect = $EggTextures/EggCrackB
@onready var egg_crack_t: TextureRect = $EggTextures/EggCrackT

func _ready() -> void:
	egg_normal.visible = true
	egg_crack_b.visible = false
	egg_crack_t.visible = false

func _process(_delta: float) -> void:
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
		
func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		if cracked: crack()
		else: self.queue_free()
	
	if event is InputEventMouseMotion:
		current_velocity = abs(Input.get_last_mouse_velocity())
		if current_velocity >= Vector2(1200, 1200) and touched_bowl:
			egg_crack.visible = true
			cracked = true
		
func crack():
	set_process(false)
	set_process_input(false)
	var bowl = get_tree().current_scene.eggcrack_bowl
	
	var tw = create_tween().tween_property(self, "global_position", Vector2(bowl.global_position.x, bowl.global_position.y - egg_crack.size.y - 40), 1).set_trans(Tween.TRANS_CUBIC)
	
	await tw.finished
	animation_player.play("crack")
	create_tween().tween_property(egg_insides, "position:y", egg_insides.global_position.y + 50, 1).set_trans(Tween.TRANS_CUBIC)
	
	await animation_player.animation_finished
	
	get_tree().current_scene.cracked_egg_amt += 1
	self.queue_free()
	

func _on_area_entered(area: Area2D) -> void: if area is BowlArea: touched_bowl = true
func _on_area_exited(area: Area2D) -> void: if area is BowlArea: touched_bowl = false
