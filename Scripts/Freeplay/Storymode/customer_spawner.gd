extends Node2D
signal add_customer()
@export var timer_min : float = 5
@export var timer_max : float = 15
@onready var add_customer_timeout: Timer = $AddCustomerTimeout


func _ready() -> void:
	add_customer_timeout.wait_time = randf_range(timer_min, timer_max)
	add_customer_timeout.start()

# Add functions here for special events
func change_min_max(type_to_change : String, new_value : float):
	match type_to_change:
		"max": timer_max = new_value
		"min": timer_min = new_value

func change_customer_weight(customer : String, new_weight : float) -> void:
	var index = GlobalVars.unlocked_customers.find(customer)
	GlobalVars.customer_weights[index] = new_weight

func _on_add_customer_timeout_timeout() -> void:
	add_customer.emit()
	add_customer_timeout.wait_time = randf_range(timer_min, timer_max)
	add_customer_timeout.start()
	
