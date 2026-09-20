extends Node2D

signal RiceCookerDone

@onready var rice_cookerw_rice: Sprite2D = $RiceCooker/RiceCookerwRice
@onready var rice_cooking_progress: ProgressBar = $RiceCookingProgress
@export var ricebowl : Node2D
@onready var rice_cooker_col: Area2D = $RiceCooker/RiceCookerCol

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		rice_cookerw_rice.visible = true
		ricebowl.queue_free()

func _on_rice_cooker_col_area_entered(area: Area2D) -> void:
	if area is RiceBowlCookArea:
		set_process_input(true)

func _on_rice_cooker_col_area_exited(area: Area2D) -> void:
	if area is RiceBowlCookArea:
		set_process_input(false)


func _on_rice_or_kanin_rice_cooker_section() -> void:
	rice_cooker_col.monitoring = true
	
	await ricebowl.tree_exited
	
	while rice_cooking_progress.value < 100:
		rice_cooking_progress.value += 5
		await get_tree().create_timer(0.1).timeout

	RiceCookerDone.emit()
