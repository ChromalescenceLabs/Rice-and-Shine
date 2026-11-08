@tool
extends VBoxContainer
@onready var button: Button = $Button
@onready var description: RichTextLabel = $DescCont/description
const LOADING_BG = preload("uid://ct36ntdromxo6")
var opened : bool = false

@export var UpgradeName : String = "UpgradeButton":
	set(value):
		UpgradeName = value
		_update_properties()

@export_multiline var Description : String = "Placeholder Description":
	set(value):
		Description = value
		_update_properties()
		
@export var Icon : Texture2D = LOADING_BG:
	set(value):
		Icon = value
		_update_properties()

func _update_properties(): 
	if not is_inside_tree(): return
	button.text = UpgradeName
	description.text = Description
	button.icon = Icon
