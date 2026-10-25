extends Control
@onready var customer_happiness_logs: Node2D = $CustomerHappinessLogs
const CUSTOMER_SERVING_SANDBOX = preload("uid://cvg4i1rwk4hbd")

func _ready() -> void:
	var data = GlobalSaveManager.fetch_scene_persistent_value("GlobalData")
	if not data == null:
		var node_data = GlobalSaveManager.fetch_node_persistent_value(data, "CustomerHappiness")
		if not node_data == null:
			for i in node_data.size():
				var hapbar = await customer_happiness_logs.new_happiness_bar(node_data[i][0], node_data[i][3])
				hapbar.info = node_data[i]
				hapbar.set_value()

func _on_serve_customers_pressed() -> void:
	SceneLoader.load_scene("uid://cvg4i1rwk4hbd", 1.5)

func _on_tree_exiting() -> void:
	var customerhappiness_data = []
	for i in customer_happiness_logs.overall_cont.get_children(): 
		customerhappiness_data.append(i.info)
	
	GlobalSaveManager.add_persistent_value(GlobalSaveManager.get_scene_path(), "CustomerHappiness", customerhappiness_data)
