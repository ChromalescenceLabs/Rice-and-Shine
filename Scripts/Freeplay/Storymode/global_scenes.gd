extends Node2D
signal remove_customer(node: TextureButton)
@warning_ignore("unused_signal") signal add_customer
@warning_ignore("unused_signal") signal duplicate_customer_happiness(hapbar: HBoxContainer)

const CUSTOMER = preload("uid://v1ke2myaadm3")
@onready var story_customers: Node2D = $StoryCustomers

@onready var happiness_bars: Node2D = $HappinessBars

# Spawn Customers Functions
func set_spawn_customers(cmin, cmax) -> void: story_customers.spawn_customer(cmin, cmax)
func pause_spawner_timer() -> void: story_customers.spawn_customer_timer.paused = true
func resume_spawner_timer() -> void: story_customers.spawn_customer_timer.paused = false

func remove_customer_func(node: TextureButton) -> void: 
	if not story_customers.get_children().is_empty():
		for i in story_customers.get_children():
			if i == node:
				i.queue_free()
				return
	else:
		remove_customer.emit(node)

#Add reset function for new days
