extends Node2D
@onready var success_particles: GPUParticles2D = $SuccessParticles

func _ready() -> void:
	self.scale = Vector2(0,0)
	
	var tw = create_tween().tween_property(self, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BOUNCE)
	await tw.finished
	
	success_particles.emitting = true

func _on_success_particles_finished() -> void:
	var tw = create_tween().tween_property(self, "scale", Vector2(0,0), 0.6).set_trans(Tween.TRANS_ELASTIC)
	await tw.finished
	
	self.queue_free()
