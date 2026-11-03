extends Control
@onready var screen_btn: OptionButton = $PAUSEMENU/GRAPHICS/MarginContainer/VBoxContainer/FULLSCREEN/ScreenBTN
@onready var aspect_btn: OptionButton = $"PAUSEMENU/GRAPHICS/MarginContainer/VBoxContainer/ASPECT RATIO/AspectBTN"
@onready var pausemenu: TabContainer = $PAUSEMENU

const RESOLUTION_DICTIONARY: Dictionary = {
	"1280 x 720" : Vector2i(1280, 720),
	"1152 x 648" :  Vector2i(1152, 648),
	"1920 x 1080": Vector2i(1920, 1080)
}

const WINDOW_MODE_ARRAY : Array[String] = [
	"Fullscreen",
	"Windowed",
	"Borderless Windowed",
	"Borderless Fullscreen"
]

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_window_mode_items()
	screen_btn.item_selected.connect(on_window_mode_selected)
	aspect_btn.item_selected.connect(on_resolution_selected)
	add_resolution_items()

func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		screen_btn.add_item(window_mode)

func on_window_mode_selected(index:  int) -> void:
	match index:
		0: #Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		1: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		2: #Borderless Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		3: #Borderless Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)

func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		aspect_btn.add_item(resolution_size_text)

func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
