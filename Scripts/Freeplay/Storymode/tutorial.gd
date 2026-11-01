extends Node2D
@onready var serving_customers_base: Node2D = $ServingCustomersBase

func _ready() -> void:
	serving_customers_base.start_day_clock()
	#GlobalScenes.set_spawn_customers(3, 10)
