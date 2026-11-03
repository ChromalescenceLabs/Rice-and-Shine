extends ColorRect
#signal pay_done
#var paying : bool = false

@onready var payment_label: RichTextLabel = $PaymentLabel
@onready var deduct_effect: RichTextLabel = $DeductEffect
@onready var pay_particles: GPUParticles2D = $PayParticles

@onready var deduct_anim: AnimationPlayer = $DeductAnim
@onready var add_anim: AnimationPlayer = $AddAnim
var current_pay : float = 0.0

func _ready() -> void:
	if not GlobalVars.paid.is_connected(upd_pay):
		GlobalVars.paid.connect(upd_pay)

func set_pay(amt: float): #Use this function when SETTING the amount
	payment_label.text = "₱ %.2f" % float(current_pay + amt)

func upd_pay(amt : float):
	if not amt < 0:
		pay_particles.emitting = true
		add_anim.play("AddAnim")
		payment_label.text = "₱ %.2f" % float(current_pay + amt)
		current_pay += amt
	else:
		deduct_pay(amt)
	
	#tried to implement rolling but like it might bug if it gets called 3 times in a row - jazz
	#if not paying: 
		#paying = true
		#pay_particles.emitting = true
		#var tba : float = 0
		#var i : int = 0
		#while not i >= 100:
			#i += 1
			#tba += amt/100.0
			#payment_label.text = "₱ %.2f" % float(current_pay + tba)
			#await get_tree().process_frame
			#
		#current_pay += amt
		#paying = false
		#pay_done.emit()
	#else:
		#await pay_done
		#paying = true
		#var tba : float = 0
		#var i : int = 0
		#while not i >= 100:
			#i += 1
			#tba += amt/100.0
			#payment_label.text = "₱ %.2f" % float(current_pay + tba)
			#await get_tree().process_frame
			#
		#current_pay += amt
		#paying = false
		#pay_done.emit()

func deduct_pay(amt : float):
	amt = abs(amt)
	deduct_anim.play("Deduct")
	deduct_effect.text = "- %.2f" % amt
	payment_label.text = "₱ %.2f" % float(current_pay - amt)
	current_pay -= amt
	
