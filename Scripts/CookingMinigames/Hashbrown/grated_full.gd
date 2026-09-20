extends Area2D
@onready var peeled: TextureRect = $Peeled
@onready var peeled_col: CollisionShape2D = $PeeledCol
@onready var grated_full: TextureRect = $"grated Full"
@onready var grated_full_col: CollisionShape2D = $"grated FullCol"
@onready var grated_full_2: TextureRect = $"grated Full2"
@onready var grated_full_col_2: CollisionShape2D = $"grated FullCol2"
@onready var texture_rect: TextureRect = $TextureRect
@onready var grated_full_col_3: CollisionShape2D = $"grated FullCol3"

var picked=false
var pickUp=false
var canGrate=false
var window_size = 4 
var children = get_children()

func _process(delta: float) -> void:
	if picked:
		self.position = get_global_mouse_position()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "grater":
		canGrate=false

func _on_mouse_entered() -> void:
	pickUp=true

func _on_mouse_exited() -> void:
	pickUp=false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		if pickUp:
			pickUp=true
	
	if event.is_action_released("Click"):
		if canGrate:

			for start in range(0, children.size() - window_size + 1, 2):
				var subset = children.slice(start, window_size)
				print("Subset from index %d:" % start)
				for child in subset:
					print("  ", child.name)
			
#if released click and if canGrate then add and free queue
