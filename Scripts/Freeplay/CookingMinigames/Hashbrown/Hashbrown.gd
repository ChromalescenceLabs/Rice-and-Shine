extends Node2D
signal peeled
#bro this is connected to the peel area of peeler dont remove (reminder for me LMAO)

@onready var line_2d: Line2D = $Line2D
@onready var peeler: Area2D = $Peeler
@onready var p_potato: TextureRect = $Line2D/AreaPPotato/PPotato
@onready var p_particles: CPUParticles2D = $Peeler/PeeledParticles
@onready var peel: Area2D = $Peeler/peel

var peeler_ogpos
var peeling: bool = false
var pickUp:bool = false

func _ready() -> void:
	p_potato.visible=false
	GlobalVars.itemEntered.connect(itemEntered)

func _process(_delta: float) -> void:
	if peeling:
		peeler.global_position = lerp(peeler.global_position, get_global_mouse_position(), 0.2)
	elif peel.canCheck:
		peeler.global_position = lerp(peeler.global_position, peeler_ogpos, 0.05)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and peeling:
		line_2d.add_point(line_2d.to_local(event.position))

func _on_area_p_potato_mouse_entered() -> void:
	if peeling and peel.areas_checked != peel.areas:
		p_potato.visible=true
		p_particles.emitting=true

func _on_area_p_potato_mouse_exited() -> void:
	p_particles.emitting=false

func _on_peeler_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click") and peel.areas_checked != peel.areas:
		peeling=true
	
	if event.is_action_released("Click"):
		peeling=false
		p_particles.emitting=false

func itemEntered(item):
	if item.name=="peel":
		peel.areas_checked=0
		peel.canCheck=true
		peeler_ogpos=Vector2(959.0, 299.0	)
