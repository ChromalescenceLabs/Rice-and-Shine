extends Node

var customer = load("uid://bivmd1klxx532")
var character_name : String = "Placeholder"
var character_order : String = "Placeholder"

# Player Info
var current_db : float = -25
var is_customer_serving: bool = false

# Systems
signal successIndEnd
signal itemEntered
signal itemExited

const SUCCIND = preload("uid://beppy36ki8xum")

func successind(tree):
	var success = SUCCIND.instantiate()
	success.position = tree.get_viewport().get_visible_rect().size / 2
	tree.add_child(success)
	
	await success.tree_exited
	successIndEnd.emit()
	
func item_enter(item) -> void:
	var tw = create_tween().tween_property(item, "position", Vector2(0,0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemEntered.emit(item)

func item_exit(item) -> void:
	var vw = get_viewport().size.x
	var tw = create_tween().tween_property(item, "position", Vector2(vw * -1, 0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	itemExited.emit()
	
func show_dialogue(indx : int, dialogue : String, node, has_order_label, dict) -> void:
	var something = DialogueManager.show_dialogue_balloon(customer, dialogue)
	something.global_position = node.global_position
	something.indx = indx
	
	if has_order_label is Callable: 
		var order_label = has_order_label.call()
		order_label.global_position = something.margin_container.global_position
		if indx == 1 or indx == 2:
			order_label.global_position.x += something.margin_container.size.x
		elif indx == 3 or indx == 4 or indx == 5:
			order_label.global_position.x -= order_label.contents_bg.size.x
		
		order_label.content_dict = dict

# Unlocks
var unlocked_foods : Array = ["rice", "pancake", "hashbrown"]

	
	
