extends TextureRect

var og_pos
var hovering : bool = false
var dragging : bool = false
var whiskable : bool = false
var mixed: bool = false
@onready var bowl: BowlArea = $"../Bowl"
@onready var egg: Sprite2D = $"../Bowl/Egg"
@onready var egg_mixed: Sprite2D = $"../Bowl/EggMixed"

func _ready() -> void:
	og_pos = self.global_position
	
func _process(_delta: float) -> void:
	if dragging: 
		self.global_position = lerp(self.global_position, get_global_mouse_position() - Vector2(self.size.x, self.size.y/2), 0.2)
		if whiskable and abs(Input.get_last_mouse_velocity()) > Vector2(800, 800): mix()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if hovering: dragging = true
	elif event.is_action_released("Click"):
		if hovering:
			dragging = false
			self.global_position = og_pos

func _on_mouse_entered() -> void: hovering = true
func _on_mouse_exited() -> void: hovering = false


func _on_whisk_area_area_entered(area: Area2D) -> void:
	if area is BowlArea: whiskable = true
		
func _on_whisk_area_area_exited(area: Area2D) -> void:
	if area is BowlArea: whiskable = false
		
func mix():
	egg_mixed.modulate.a += 0.005
	egg.rotation_degrees += 5
	egg_mixed.rotation_degrees += 5
	
	if egg_mixed.modulate.a >= 1 and not mixed:
		mixed = true
		bowl.monitorable = false
		get_tree().current_scene.egg_mix_finished.emit()
