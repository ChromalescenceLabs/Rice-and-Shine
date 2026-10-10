extends TextureRect

var final_pos
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func initialization() -> bool:
	var data = GlobalSaveManager.fetch_scene_persistent_value(GlobalSaveManager.get_scene_path())
	if data == null:
		self.modulate.a = 1.0
		animation_player.play("enter_exit")
		
		#final_pos = self.global_position
		#print(final_pos)
		#
		## self.reparent(get_tree().current_scene)
		##
		##self.global_position = Vector2(1280, final_pos.y) + Vector2(self.size.x, 0)
		##
		##var tw = create_tween().tween_property(self, "global_position:x", final_pos.x, 0.5).set_trans(Tween.TRANS_CUBIC)
		##
		## self.reparent(get_tree().current_scene.customers_cont)
		##
		##await tw.finished
			
	return true
