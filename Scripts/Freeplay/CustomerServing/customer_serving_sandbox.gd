extends Node2D

const SERVE_BOWL = preload("uid://curuxisd3l6in")
@onready var bowl_labels: Node2D = $BowlLabels
@onready var bowl_conts: HBoxContainer = $Control/BowlConts
@onready var freed_bowls: Control = $Control/FreedBowls

@onready var add_bowl: Button = $Control/BowlConts/AddBowl
var bowl_no : int = 0

func _ready() -> void:
	GlobalVars.is_customer_serving = true
	
	#Checks if Scene has saved data
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	if not data == null:
		# Check if a Node in that scene has data
		var node_data = GlobalSaveManager.fetch_node_persistent_value(data, "Bowls")
		if not node_data == null:
			for i in node_data.size():
				var bowl = await add_bowl_func()
				bowl.contentDict = node_data[i]

func _on_add_bowl_pressed() -> void: add_bowl_func()

func _on_freed_bowls_child_exiting_tree(node: Node) -> void:
	if node is Bowl:
		var pos = node.final_pos
		bowl_no -= 1
		
		for i in bowl_conts.get_children():
			if i.global_position == pos:
				i.queue_free()
				break
		
		if bowl_no < 7:
			add_bowl.disabled = false
			add_bowl.visible = true
		
		await node.tree_exited
		
		for i in freed_bowls.get_child_count():
			var current_back_bowl = bowl_conts.get_children()[i]
			var current_freed_bowl = freed_bowls.get_children()[i]
			
			if current_back_bowl is TextureRect:
				current_freed_bowl.final_pos = current_back_bowl.global_position
				current_freed_bowl.global_position = current_back_bowl.global_position

func add_bowl_func() -> TextureRect:
	var newBowl = SERVE_BOWL.instantiate()
	newBowl.modulate.a = 0.0
	bowl_conts.add_child(newBowl)

	var last_index := bowl_conts.get_child_count() - 1
	bowl_conts.move_child(newBowl, max(0, last_index - 1))

	await get_tree().process_frame

	newBowl.initialization()
	
	bowl_no += 1
	
	if bowl_no == 7:
		add_bowl.disabled = true
		add_bowl.visible = false
	
	return newBowl

func _on_tree_exiting() -> void:
	# Saves the needed bowl data in an array
	var bowl_data = []
	for i in freed_bowls.get_children():
		bowl_data.append(i.contentDict)
	
	var dict := {}
	# Saves the node's name, with the needed data, into the dictionary to be added as persistent value
	dict["Bowls"] = bowl_data

	GlobalSaveManager.add_persistent_value(GlobalSaveManager.get_scene_path(), dict)


func _on_button_pressed() -> void:
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)
