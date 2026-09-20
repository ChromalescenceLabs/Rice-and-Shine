extends Node2D
@onready var line_2d: Line2D = $Line2D
@onready var peeler: Area2D = $Peeler
@onready var p_potato: TextureRect = $Line2D/AreaPPotato/PPotato
@onready var p_particles: CPUParticles2D = $Peeler/PParticles

var peeling: bool = false
var isPeeler = false


func _ready() -> void:
	p_potato.visible=false

func _process(delta: float) -> void:
	if peeling:
		peeler.global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and peeling:
		line_2d.add_point(line_2d.to_local(event.position))

	if event.is_action_released("Click") and isPeeler:
		peeling = true

func _on_peeler_mouse_entered() -> void:
	isPeeler = true

func _on_peeler_mouse_exited() -> void:
	isPeeler = false

func _on_area_p_potato_mouse_entered() -> void:
	if isPeeler:
		p_potato.visible=true
