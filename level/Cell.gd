extends Node



var row;
var column;
var depth;

var north;
var south;
var east;
var west;
var below;
var above;

var links;

var distances = preload("res://level/Distance.tscn");
var distance;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create(x, y):
	row = x;
	column = y;
	links = {};
	
func link(cell, bidirectional):
	links[cell] = true;
	if (bidirectional):
		cell.link(self, false);
		
func unlink(cell, bidirectional):
	links.erase(cell);
	if (bidirectional):
		cell.unlink(self, false);

func get_links():
	return links.keys();

func is_linked():
	return !(links.is_empty());

func neighbors():
	var list = [];
	if north != null:
		list.push_back(north);
	if south != null:
		list.push_back(north);
	if east != null:
		list.push_back(north);
	if west != null:
		list.push_back(north);


func find_distances():
	distance = distances.new();
	var frontier = [self];
	
	while !frontier.is_empty():
		var new_frontier = [];
		
		for front in frontier:
			for linked_cell in front.links:
				if linked_cell != null:
					distance[linked_cell] = distances[front] + 1;
					new_frontier.push_back(linked_cell);
		
		frontier = new_frontier;
		
	return distance;
