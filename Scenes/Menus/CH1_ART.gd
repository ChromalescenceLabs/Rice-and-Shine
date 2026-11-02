extends TextureRect

func _ready() -> void:
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	if not CHAP1 or not CHAP2 or not CHAP3:
		return
	if CHAP1.modulate == Color(1,1,1):
		desc2.text = "CHAPTER 1 DESCRIPTION"
	elif CHAP2.modulate == Color(1,1,1):
		desc2.text = "CHAPTER 2 DESCRIPTION"
	elif CHAP3.modulate == Color(1,1,1):
		desc2.text = "CHAPTER 3 DESCRIPTION"
	else: 
		pass
