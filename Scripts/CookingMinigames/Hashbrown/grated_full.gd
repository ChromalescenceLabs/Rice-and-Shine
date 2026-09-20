extends Area2D
@onready var peeled: TextureRect = $Peeled
@onready var peeled_col: CollisionShape2D = $PeeledCol
@onready var grated_full: TextureRect = $"grated Full"
@onready var grated_full_col: CollisionShape2D = $"grated FullCol"
@onready var grated_full_2: TextureRect = $"grated Full2"
@onready var grated_full_col_2: CollisionShape2D = $"grated FullCol2"
@onready var texture_rect: TextureRect = $TextureRect
@onready var grated_full_col_3: CollisionShape2D = $"grated FullCol3"

var origPos=self.global_position
var picked=false
var pickUp=false
var canGrate=false 
var apple =1
var subset = get_subset_by_index(apple)

func _ready() -> void:
	print('hi')
	
	for start in range(0, self.get_children().size(), 2):
		var subset = self.get_children().slice(start,start+ 4)
		print("Subset from index %d:" % start)
		for child in subset:
			print("  ", child.name)

func get_subset_by_index(apple: int):
	var step = 2
	var window_size = 4

	var start = apple * 2

	if start >= self.get_children().size():
		print("No subset for apple = ", apple)
		return 
	
	var subset = self.get_children().slice(start, window_size)
	print("Subset %d (apple=%d):" % [apple + 1, apple])
	for child in subset:
		print("  ", child.name)
	return subset


func _process(delta: float) -> void:
	if picked:
		self.global_position = get_global_mouse_position()
	else:
		self.global_position = origPos

func _on_mouse_entered() -> void:
	pickUp=true

func _on_mouse_exited() -> void:
	pickUp=false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		if pickUp:
			picked=true
	
	if event.is_action_released("Click"):
		picked=false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "grater":
		canGrate=true
		print("guys how do i do this")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "grater":
		canGrate=false
