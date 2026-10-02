extends Area2D
@onready var peeled: TextureRect = $Peeled
@onready var peeled_col: CollisionShape2D = $PeeledCol
@onready var grated_full: TextureRect = $"grated Full"
@onready var grated_full_col: CollisionShape2D = $"grated FullCol"
@onready var grated_full_2: TextureRect = $"grated Full2"
@onready var grated_full_col_2: CollisionShape2D = $"grated FullCol2"
@onready var texture_rect: TextureRect = $TextureRect
@onready var grated_full_col_3: CollisionShape2D = $"grated FullCol3"

var origPos
var picked=false
var canGrate=false 
var startProcess=false
var amtChange =-1
var dropped=false


func _ready() -> void:
	origPos = self.global_position
	GlobalVars.enterDone.connect(_on_enterDone)

func grate(amt:int):
	var start = amt * 2

	var subset = self.get_children().slice(start, start+2)
	for child in subset:
		#First 2 becomes invis
		print(">", child.name)
		child.visible= false
	subset = self.get_children().slice(start+2, start+4)
	for child in subset:
		#last 2 becomes vis
		print(">", child.name)
		child.visible= true

func _process(_delta: float) -> void:
	if picked:
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
	else:
		self.global_position = lerp(self.global_position, origPos, 0.05)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		picked=true
	
	if event.is_action_released("Click"):
		picked=false

func _on_area_entered(area: Area2D) -> void:
	if area.name == "grater" and startProcess:
		canGrate=true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=false
		if not picked and startProcess:
			amtChange+=1
			grate(amtChange)
			print(amtChange)

func _on_enterDone():
	startProcess=true
	print(amtChange)
