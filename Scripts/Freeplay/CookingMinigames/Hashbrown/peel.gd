extends Area2D

signal peeled

@onready var peeled_particles: CPUParticles2D = $"../PeeledParticles"

var areas:int = 34
var areas_checked:int = 0
var canCheck=false

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
