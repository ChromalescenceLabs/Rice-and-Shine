extends Node2D

signal soy_sauce_done
signal calamansi_done
signal ketchup_done
signal sprite_done

@onready var soy_sauce_bar: ProgressBar = $SoySauceBar
@onready var calamansi_bar: ProgressBar = $CalamansiBar
@onready var ketchup_bar: ProgressBar = $KetchupBar
@onready var sprite_bar: ProgressBar = $SpriteBar

func fade_in(bar):
	var newtw = create_tween().tween_property(bar, "modulate:a", 1, 1).set_trans(Tween.TRANS_ELASTIC)
	await newtw.finished
	
func fade_out(bar):
	var tw = create_tween().tween_property(bar, "modulate:a", 0, 1).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished

func _on_soy_sauce_bar_value_changed(value: float) -> void:
	if value >= 100:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		soy_sauce_done.emit()

func _on_calamansi_bar_value_changed(value: float) -> void:
	if value >= 100:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		calamansi_done.emit()

func _on_ketchup_bar_value_changed(value: float) -> void:
	if value >= 100:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		ketchup_done.emit()

func _on_sprite_bar_value_changed(value: float) -> void:
	if value >= 100:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		sprite_done.emit()

func _on_soy_sauce_done() -> void:
	await fade_out(soy_sauce_bar)
	print("done")
	fade_in(calamansi_bar)
	
func _on_calamansi_done() -> void:
	await fade_out(calamansi_bar)
	fade_in(ketchup_bar)

func _on_ketchup_done() -> void:
	await fade_out(ketchup_bar)
	fade_in(sprite_bar)

func _on_sprite_done() -> void:
	await fade_out(sprite_bar)
	fade_in(sprite_bar)
