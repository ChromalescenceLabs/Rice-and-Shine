extends Node2D
@onready var upgr_label_anim: AnimationPlayer = $UpgradesPanelComponents/UpgrLabelAnim
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")


func _ready() -> void: GlobalVars.day += 1

func _on_exit_upgr_panel_pressed() -> void: upgr_label_anim.play_backwards("UpgradeLabelAnim")
func _on_open_upgrades_pressed() -> void: upgr_label_anim.play("UpgradeLabelAnim")

func _on_next_day_pressed() -> void:
	pass # Replace with function body.

func _on_returnto_main_menu_pressed() -> void: SceneLoader.load_scene("uid://benuikw1v40e", 1.5, LOADING_SCREEN_FADE)
