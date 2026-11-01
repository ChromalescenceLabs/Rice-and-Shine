extends Area2D

signal done
@onready var potato: Area2D = $"../potato"
@onready var pan: Area2D = $"../Pan"
@onready var oil: Oil = $"../Oil"
@onready var progress_bar_change_time: Timer = $"../ProgressBar/ProgressBarChangeTime"
@onready var progress_bar: ProgressBar = $"../ProgressBar"

var moldOnPan=false
var curMold
var molded = 0

func _on_ready() -> void:
	for child in get_parent().get_children():
		if "mold" in child.name.to_lower():
			print(child.name)
			child.drop.connect(drop.bind(child))

func drop(mold):
	if not moldOnPan && mold.areaEnter:
		if mold.areaEnter.name.to_lower() == "pan":
			if pan.has_oil:
				mold.ogPos = Vector2(382, 269)
				moldOnPan = true
				progress_bar_change_time.start()
				progress_bar.modulate.a=1
				progress_bar.visible=true
				curMold=mold
			else: GlobalVars.shake(pan)

func _on_progress_bar_change_time_timeout() -> void:
	if progress_bar.value<100:
		progress_bar.value+=1
		curMold.modulate = curMold.modulate.lerp(Color(4.937, 0.914, 0.503, 1.0), .03)
		
	elif progress_bar.value==100:
		progress_bar_change_time.stop() 
		GlobalVars.shake(progress_bar)
		create_tween().tween_property(progress_bar, "modulate:a", 0, .5).set_trans(Tween.TRANS_CUBIC)
		await get_tree().create_timer(.2).timeout
		progress_bar.visible=false
		molded +=1
		if molded ==3:
			done.emit()
			print("FUCKING DONE")

		await GlobalVars.item_exit(curMold)
		curMold.visible = false
		curMold.set_process(false)
		pan.unoil()
		moldOnPan=false
		progress_bar.value=0
		print(molded)
