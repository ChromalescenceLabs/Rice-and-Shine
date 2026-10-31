extends Node2D
@warning_ignore("unused_signal") signal add_customer
@warning_ignore("unused_signal") signal duplicate_customer_happiness(hapbar: HBoxContainer)

const CUSTOMER = preload("uid://v1ke2myaadm3")
var customer_num : int = 0
@onready var story_customers: Node2D = $StoryCustomers

@onready var happiness_bars: Node2D = $HappinessBars

# Spawn Customers Functions
func set_spawn_customers(cmin, cmax) -> void: story_customers.spawn_customer(cmin, cmax)
func pause_spawner_timer() -> void: story_customers.spawn_customer_timer.paused = true
func resume_spawner_timer() -> void: story_customers.spawn_customer_timer.paused = false
