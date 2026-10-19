extends HBoxContainer
signal upset(index : int)
@onready var icon: TextureRect = $Icon
@onready var bar: ProgressBar = $Bar
@onready var timer: Timer = $Timer
var indx : int 
func _on_timer_timeout() -> void: bar.value -= 1

func _on_bar_value_changed(value: float) -> void:
	if value <= 0:
		var siblings : Array = self.get_parent().get_children()
		for i in siblings:
			if i == self:
				indx = siblings.find(self)
				
		upset.emit(indx)
		self.queue_free()
