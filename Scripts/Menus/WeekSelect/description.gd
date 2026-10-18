extends Label


func _on_weeks_change_week(current_week) -> void:
	var number= current_week.name.to_lower().substr(4, -1)
	match number:
		"one":
			text="yo week " + number
		"two":
			text="yo week " + number
		"three":
			text="yo week " + number
		"four":
			text="yo week " + number
		"five":
			text="yo week " + number
		"six":
			text="yo week " + number
		"seven":
			text="yo week " + number
