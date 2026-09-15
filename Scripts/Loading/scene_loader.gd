extends Node

signal load_finished

var loading_screen : PackedScene = preload("uid://chgdopktb0d2w")
var loaded_resource : PackedScene
var scene_path : String               
var previous_scene_path : String       
var use_sub_threads : bool = true

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(false)
	
func load_scene(_scene_path: String, duration: float) -> void:
	previous_scene_path = scene_path
	scene_path = _scene_path
	
	var new_load_screen = loading_screen.instantiate()
	add_child(new_load_screen)
	load_finished.connect(new_load_screen._on_load_finished)
	
	await new_load_screen.loading_screen_ready
	new_load_screen.duration = duration
	
	start_load()
	
func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)
		
func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path)
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()
			
func get_previous_scene_path() -> String:
	return previous_scene_path 
