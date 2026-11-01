extends Node2D

const CUSTOMER = preload("uid://v1ke2myaadm3")
var customer_num : int = 0:
	set(value):
		customer_num = value

@onready var story_customers: Node2D = $"."

var timer_min : float = 5
var timer_max : float = 15
@onready var spawn_customer_timer: Timer = $"../SpawnCustomerTimer"


func spawn_customer(cust_time_min: float, cust_time_max: float) -> void:
	timer_min = cust_time_min
	timer_max = cust_time_max
	spawn_customer_timer.wait_time = randf_range(timer_min, timer_max)
	spawn_customer_timer.start()

# Add functions here for special events
func change_min_max(type_to_change : String, new_value : float):
	match type_to_change:
		"max": timer_max = new_value
		"min": timer_min = new_value

func change_customer_weight(customer : String, new_weight : float) -> void:
	var index = GlobalVars.unlocked_customers.find(customer)
	GlobalVars.customer_weights[index] = new_weight

func _on_spawn_customer_timer_timeout() -> void:
	if not customer_num >= 6:
		add_customer_func()
		spawn_customer_timer.wait_time = randf_range(timer_min, timer_max)
	
	spawn_customer_timer.start()

func add_customer_func(type : String = "Random", wants : Dictionary = {}) -> TextureButton:
	var customer = CUSTOMER.instantiate()
	story_customers.add_child(customer)
	var c_info = customer.initialization(type, wants)
	customer_num += 1
	
	get_parent().duplicate_customer_happiness.emit(c_info["Hapbar"])
	
	return customer
