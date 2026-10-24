extends Node2D

const CUSTOMER = preload("uid://v1ke2myaadm3")
const SERVE_BOWL = preload("uid://curuxisd3l6in")
const FOOD_CONT = preload("uid://csole0o4ydmgm")

@onready var bowl_labels: Node2D = $BowlLabels
@onready var bowl_conts: HBoxContainer = $Control/BowlConts
@onready var freed_bowls: Control = $Control/FreedBowls
@onready var food_conts: HBoxContainer = $Control/ScrollContainer/FoodConts
@onready var customers_cont: HBoxContainer = $Control/CustomersCont
@onready var customer_happiness_logs: Node2D = $CustomerHappinessLogs

@onready var add_bowl: Button = $Control/BowlConts/AddBowl
var bowl_no : int = 0

func _ready() -> void:
	GlobalVars.is_customer_serving = true
	
	#Checks if Scene has saved data
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	print(data)
	if not data == null:
		# Check if a Node in that scene has data for bowls
		var node_data = GlobalSaveManager.fetch_node_persistent_value(data, "Bowls")
		if not node_data == null:
			for i in node_data.size():
				var bowl = await add_bowl_func(true)
				bowl.contentDict = node_data[i]
				bowl.add_to_group("oldBowls")
				
		# Check if a Node in that scene has data for FoodConts	
		node_data = GlobalSaveManager.fetch_node_persistent_value(data, "FoodConts")
		if not node_data == null:
			var foodcontchildren = food_conts.get_children()
				
			for i in node_data.size():
				foodcontchildren[i].qty = node_data[i]
				
		# Check if a Node in that scene has data for CustomerConts	
		node_data = GlobalSaveManager.fetch_node_persistent_value(data, "CustomerConts")
		if not node_data == null:
			for i in node_data.size():
				var customer = add_customer()
				customer.customer_info = node_data[i]
				customer.update_texture()

func _on_add_bowl_pressed() -> void: add_bowl_func(false)

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

func add_bowl_func(is_old : bool) -> TextureRect:
	var newBowl = SERVE_BOWL.instantiate()
	newBowl.modulate.a = 0.0
	bowl_conts.add_child(newBowl)

	var last_index := bowl_conts.get_child_count() - 1
	bowl_conts.move_child(newBowl, max(0, last_index - 1))

	await get_tree().process_frame

	if is_old:
		newBowl.add_to_group("oldBowls")
	
	newBowl.initialization()
	
	bowl_no += 1
	
	if bowl_no == 7:
		add_bowl.disabled = true
		add_bowl.visible = false
	
	return newBowl

func add_customer() -> TextureButton:
	var newCustomer = CUSTOMER.instantiate()
	newCustomer.modulate.a = 0.0
	customers_cont.add_child(newCustomer)
	var type = newCustomer.initialization()
	newCustomer.indx = customers_cont.get_child_count()
	customer_happiness_logs.new_happiness_bar(type)
	
	return newCustomer

func _on_tree_exiting() -> void:
	var bowl_data = []
	for i in freed_bowls.get_children(): bowl_data.append(i.contentDict)
	
	var foodcont_data = []
	for i in food_conts.get_children(): foodcont_data.append(i.qty)
	
	var customercont_data = []
	for i in customers_cont.get_children(): customercont_data.append(i.customer_info)
	
	var customerhappiness_data = []
	for i in customer_happiness_logs.overall_cont.get_children(): 
		customerhappiness_data.append(i.info)
	
	GlobalSaveManager.add_persistent_value(GlobalSaveManager.get_scene_path(), "Bowls", bowl_data)
	GlobalSaveManager.add_persistent_value(GlobalSaveManager.get_scene_path(), "FoodConts", foodcont_data)
	GlobalSaveManager.add_persistent_value(GlobalSaveManager.get_scene_path(), "CustomerConts", customercont_data)
	GlobalSaveManager.add_persistent_value("GlobalData", "CustomerHappiness", customerhappiness_data)

func upd_customer_indexes(current_node_index : int) -> void:
	for i in customers_cont.get_children().slice(current_node_index):
		i.indx -= 1
 
func _on_temp_pressed() -> void:
	add_customer()


func _on_customer_happiness_logs_remove_customer(index: int) -> void:
	var customer = customers_cont.get_children()[index]
	customer.animation_player.play_backwards("enter_exit")
	await customer.animation_player.animation_finished
	customer.queue_free()
	

func _on_customers_cont_child_exiting_tree(node: Node) -> void:
	var indx : int = 0
	for i in customers_cont.get_children():
		if i == node:
			customer_happiness_logs.overall_cont.get_children()[indx].queue_free()
		indx += 1


func _on_exit_pressed() -> void:
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1)
