extends Control
class_name HUD

@export var energy_cell : Label
@export var portal_label : Label

func update_energy_cell(number : int):
	energy_cell.text = "x " + str(number)
	
func portal_opened():
	portal_label.text = "Portal open!"
	
func portal_closed():
	portal_label.text = "Portal closed... Get energy cells!"
