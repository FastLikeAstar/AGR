extends Node

var root;
var cells;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create(given_root):
	root = given_root;
	cells = {};
	cells[root] = 0;
	
func get_cell(cell):
	cells.add(cell);

func set_cell(cell, distance):
	cells[cell] = distance;
	
func get_cells():
	return cells.keys();


