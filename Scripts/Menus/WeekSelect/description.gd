extends Label

func _on_weeks_change_week(current_week) -> void:
	var number= current_week.name.to_lower().substr(4, -1)
	match number:
		"one":
			text="A karinderya that stands high and proud no matter the storm. In the midst of it all, a girl with big dreams and an even bigger heart. Welcome to Rice and Shine. Ano po ang gusto niyo?"
		"two":
			text="The karinderya slowly starts to bloom. Customers, flock towards the window. Upgrades are slowly being bought. "
		"three": #ito ba ung nahospital si lola lmao
			text="An ominous feeling looms over the whole karinderya. Dread and worry starts to swirl around your head. What is happening today?"
		"four": 
			text= "A girl starts to struggle to make ends meet. As gloomier days comes to pass, customers starts to become scarcer with every fleeting moment"
		"five":
			text="More customers starts to make an appearance. More work starts to compile. More new ingredients starts to arrive"
		"six":
			text="Days starts to feel lighter again as the journey nearly reaches the end. The person who long to meet again starts to feel a bit better."
		"seven":
			text="Eveery penny earned is spent towards those who need it the most. Was it all worth it? That is for you to know."
