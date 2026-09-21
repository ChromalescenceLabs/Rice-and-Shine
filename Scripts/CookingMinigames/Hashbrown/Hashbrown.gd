extends Node2D

signal peeled

@onready var line_2d: Line2D = $Line2D
@onready var peeler: Area2D = $Peeler
@onready var p_potato: TextureRect = $Line2D/AreaPPotato/PPotato
@onready var p_particles: CPUParticles2D = $Peeler/PeeledParticles

var peeler_ogpos

var peeling: bool = false
var pickUp:bool = false

func _ready() -> void:
	peeler_ogpos = peeler.global_position
	p_potato.visible=false
	
func _process(_delta: float) -> void:
	if peeling:
		peeler.global_position = lerp(peeler.global_position, get_global_mouse_position(), 0.2)
	else:
		peeler.global_position = lerp(peeler.global_position, peeler_ogpos, 0.05)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and peeling:
		line_2d.add_point(line_2d.to_local(event.position))

func _on_peeler_mouse_entered() -> void:
	pickUp=true

func _on_peeler_mouse_exited() -> void:
	pickUp=false

func _on_area_p_potato_mouse_entered() -> void:
	if peeling:
		p_potato.visible=true

func _on_peeler_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		if pickUp:
			peeling=true
	
	if event.is_action_released("Click"):
		peeling=false
