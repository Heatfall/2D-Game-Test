extends Node


var starting_area = 1
var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"

var energy_cell = 0
var area_container : Node2D
var player : PlayerController
var hud : HUD

func _ready():
	hud = get_tree().get_first_node_in_group("PortalHUD")
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	load_area(starting_area)


func next_level():
	current_area += 1
	load_area(current_area)
	

func load_area(area_number):
	#Checking the new scene path
	var full_path = area_path + "Level" + str(current_area) + ".tscn"
	var scene = load(full_path) as PackedScene
	if !scene:
		return
	#Removing the previous scene
	for child in area_container.get_children():
		child.queue_free()
		await child.tree_exited
	#Setting up the new scene
	var instance = scene.instantiate()
	area_container.add_child(instance)
	reset_energy_cells()
	var player_start_position = get_tree().get_first_node_in_group("player_start_position") as Node2D
	player.teleport_to_location(player_start_position.position)
	

func add_energy_cell():
	energy_cell += 1
	hud.update_energy_cell(energy_cell)
	if energy_cell >= 4:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()
		hud.portal_opened()
		
func reset_energy_cells():
	energy_cell = 0;
	hud.update_energy_cell(energy_cell)
	hud.portal_closed()
