extends Area2D

signal peeled

@onready var peeled_particles: CPUParticles2D = $"../PeeledParticles"
@onready var checking_areas: Node2D = $"../../Line2D/CheckingAreas"

var areas:int 
var areas_checked:int = 0
var canCheck=false

func _ready() -> void:
	areas=checking_areas.get_children().size()

func _process(_delta: float) -> void:
	if areas_checked == areas:
		peeled.emit()
		peeled_particles.emitting=false
		set_process(false)
		get_node("/root").set_process(false)


func _on_area_entered(area: Area2D) -> void:
	if area is peel_area_checker and not area.checked and canCheck:
		area.checked = true
		areas_checked += 1
		print(areas_checked)
