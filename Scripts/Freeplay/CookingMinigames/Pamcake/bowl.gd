extends Area2D
class_name BatterBowl

signal batterBowlEmpty

var batterLevel : int = 5:
	set(value):
		batterLevel = value
		if batterLevel == 5:
			for i in self.get_children():
				if not i.name == "BowlBatterStage1":	
					i.visible = false
				else:
					i.visible = true
		elif batterLevel == 3:
			for i in self.get_children():
				if not i.name == "BowlBatterStage2":
					i.visible = false
				else:
					i.visible = true
		elif batterLevel == 2:
			for i in self.get_children():
				if not i.name == "BowlBatterStage3":
					i.visible = false
				else:
					i.visible = true
		elif batterLevel == 1:
			for i in self.get_children():
				if not i.name == "BowlBatterStage4":
					i.visible = false
				else:
					i.visible = true
		elif batterLevel == 0:
			for i in self.get_children():
				if not i.name == "BowlBatterStage5":
					i.visible = false
				else:
					i.visible = true
					
			batterBowlEmpty.emit()
