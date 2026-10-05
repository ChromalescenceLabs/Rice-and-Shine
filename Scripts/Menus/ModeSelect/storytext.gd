extends RichTextLabel
#ignore this, i did this before i knew about bbcode
@export var speed: float = 3.0
@export var direction: Vector2 = Vector2.ZERO
@export var changeinterval: float = 1.5
@export var distance: float = 20.0

var timesincechange: float = 0.0

#randomizes direction
func _pick_new() -> void:
	var randomangle = randf_range(0, 2 * PI)
	direction = Vector2.from_angle(randomangle)

#when hovered, it picks direc
func _on_story_mouse_entered() -> void:
	_pick_new()

#makes it change every 1.5
func _process(delta:float) -> void:
	timesincechange += delta
	if timesincechange >= changeinterval:
		_pick_new()
		timesincechange = 0.0
	position += direction * speed * delta
