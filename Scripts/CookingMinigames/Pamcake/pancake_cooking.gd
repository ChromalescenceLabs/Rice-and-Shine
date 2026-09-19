extends Node2D

@onready var batter_cup = $BatterStuff/BatterCup
@onready var bowl_batter = $BatterStuff/BowlBatter
@onready var pan = $Pan
@onready var oil = $Oil



func _ready() -> void:
	print("Batter Cup: ", batter_cup)
	print("Bowl Batter: ", bowl_batter)
	print("Pan: ", pan)
	print("Oil: ", oil)
