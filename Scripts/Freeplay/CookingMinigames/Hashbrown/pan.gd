extends Area2D

@onready var oilAsset: Oil = $"../Oil"

var has_hdog: bool = false
var has_oil: bool = false
var fried = false
var mold

func oil() -> void:
	has_oil = true
	find_child("Pan").visible=false
	find_child("PanOil").visible=true

func unoil() -> void:
	has_oil = false
	find_child("Pan").visible=true
	find_child("PanOil").visible=false

func _ready() -> void:
	unoil()
	oilAsset.snap_to_og_pos=true
