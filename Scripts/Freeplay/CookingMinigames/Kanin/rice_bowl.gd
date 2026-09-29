extends Area2D
class_name RiceBowl

signal riceCupDone

var riceAmt : int = 0:
	set(value):
		riceAmt = value
		if riceAmt == 1:
			for i in self.get_children():
				if not i.name == "RiceBowlThird":
					i.visible = false
				else:
					i.visible = true
		elif riceAmt == 3:
			for i in self.get_children():
				if not i.name == "RiceBowlHalf":
					i.visible = false
				else:
					i.visible = true
		elif riceAmt == 5:
			for i in self.get_children():
				if not i.name == "RiceBowlFull":
					i.visible = false
				else:
					i.visible = true
					
			riceCupDone.emit()
			
