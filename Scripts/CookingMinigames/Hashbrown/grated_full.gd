extends Area2D
@onready var peeled: TextureRect = $Peeled
@onready var peeled_col: CollisionShape2D = $PeeledCol
@onready var grated_full: TextureRect = $"grated Full"
@onready var grated_full_col: CollisionShape2D = $"grated FullCol"
@onready var grated_full_2: TextureRect = $"grated Full2"
@onready var grated_full_col_2: CollisionShape2D = $"grated FullCol2"
@onready var texture_rect: TextureRect = $TextureRect
@onready var grated_full_col_3: CollisionShape2D = $"grated FullCol3"

@onready var grated: TextureRect = $"../Grated/grated"
@onready var grated_2: TextureRect = $"../Grated/grated2"
@onready var grated_3: TextureRect = $"../Grated/grated3"
@onready var grated_4: TextureRect = $"../Grated/grated4"

@onready var grate_timer: Timer = $"../GrateTimer"
@onready var detector: TextureButton = $Detector

var origPos
var picked=false
var pickUp=false
var canGrate:bool = false
var shaking:bool =false 
var amtChange =0
var mouse_vel
var iteration = 0

func _ready() -> void:
	grate_timer.start()
	grate_timer.paused = true
	origPos = self.global_position
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and picked:
		mouse_vel = Input.get_last_mouse_velocity()
		if mouse_vel > Vector2(2000, 2000):
			shaking = true
	else:
		shaking = false

func _process(_delta: float) -> void:
	if picked: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
	else: self.global_position = lerp(self.global_position, origPos, 0.05)

func _on_mouse_entered() -> void: 
	pickUp=true 
	print("can pick up")
func _on_mouse_exited() -> void: 
	pickUp=false
	print("nope")


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		if pickUp:
			picked=true
	if event.is_action_released("Click"):
		picked=false

func _on_grater_body_entered(body: Node2D) -> void:
	if body == self:
		canGrate = true
		if shaking and canGrate:
			grate_timer.paused = false


func _on_grater_body_exited(body: Node2D) -> void:
	canGrate = false
	if body == self:
		grate_timer.paused = true
		
		
func _on_grate_timer_timeout() -> void:
	iteration += 1
	
	# logic for grating mech heree
	#match iteration:
		#1: 
			#peeled.visible = false
			#peeled_col.disabled = true
			#
			#grated_full.visible = true
			#grated_full_col.disabled = false
			#
			#grated.visible = true
			#
		#2: 
			#grated_full.visible = false
			#grated_full_col.disabled = true
			#
			#grated_full_2.visible = true
			#grated_full_col_2.visible = false
			#
			#grated_2.visible = true
		#3:
			#grated_full_2.visible = false
			#grated_full_col_2.visible = true
			#
			#texture_rect.visible = true
			#grated_full_col.disabled = false
			#grated_3.visible = true
	#
	#grate_timer.start()
	#grate_timer.paused = true

#print('hi')
	#get_subset_by_index(amtChange)
	#
	#for start in range(0, self.get_children().size(), 2):
		#var subset = self.get_children().slice(start,start+ 4)
		#print("Subset from index %d:" % start)
		#for child in subset:
			#print("  ", child.name)
#
#func get_subset_by_index(amt:int):
	#var step = 2
	#var window_size = 4
#
	#var start = amt * 2
#
	#if start >= self.get_children().size():
		#print(self.get_children().size(), "No subset for ", amt)
		#return 
	#
	#var subset = self.get_children().slice(start, start+2)
	#for child in subset:
		#print("  ", child.name)
		#child.visible= false
	#subset = self.get_children().slice(start+2, start+4)
	#for child in subset:
		#print("  ", child.name)
		#child.visible= true
	#return subset


func _on_detector_mouse_entered() -> void:
	pass # Replace with function body.
