extends Node2D
@onready var success_particles: GPUParticles2D = $SuccessParticles
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("in")
	await animation_player.animation_finished
	#self.scale = Vector2(0,0)
	
	#var tw = create_tween().tween_property(self, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BOUNCE)
	#await tw.finished
	await get_tree().create_timer(.5).timeout
	success_particles.emitting = true
	await get_tree().create_timer(.5).timeout
	success_particles.one_shot = true
	await get_tree().create_timer(.5).timeout
	var tw = create_tween().tween_property(self, "scale", Vector2(0,0), 0.6).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	self.queue_free()

	
