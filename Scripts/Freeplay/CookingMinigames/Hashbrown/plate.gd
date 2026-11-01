extends Area2D

signal done
@onready var potato: Area2D = $"../potato"
@onready var pan: Area2D = $"../Pan"
@onready var oil: Oil = $"../Oil"

func _on_ready() -> void:
	for child in get_parent().get_children():
		if "mold" in child.name.to_lower():
			print(child.name)
