extends Node2D

var grid;
var cell;
var cell_ref = preload("res://level/Cell.tscn");
@onready var tileMap = $TileMap;
var borders;

var rows;
var columns;
var floors;
var rng;
var starting_inset = 2;

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	create(20, 10);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create(x, y):
	rows = x;
	columns = y;
	borders = Rect2(starting_inset,starting_inset, rows-starting_inset, columns -starting_inset);
	generate_level()
	#grid = prepare_grid();
	#configure_cells();

func generate_level():
	var walker = Walker.new(Vector2(rng.randi_range(starting_inset,rows-starting_inset), rng.randi_range(starting_inset,columns-starting_inset)), borders);
	var map = walker.walk(10);
	for location in map:
		tileMap.set_cell(0,location);
	tileMap.set_cells_terrain_connect(0,map, 0, 0, false);
	#tileMap.update_bitmask_region(borders.position, borders.end);
	
func prepare_grid():
	for x in rows:
		for y in columns:
			var cell = cell_ref.new();
			cell.create(x,y);
			add_child(cell);
			grid[x][y] = cell; # Maybe remove? pg 20 of Mazes for Programmers

func configure_cells():
	var x;
	var y;
	for cell in grid:
		x = cell.row;
		y = cell.column;
		cell.north = grid[x - 1][y];
		cell.south = grid[x + 1][y];
		cell.east = grid[x][y - 1];
		cell.west = grid[x][y + 1];


func get_at(row, column):
	if row >= rows || row < 0:
		return null;
	if column >= columns || column < 0:
		return null;
	return grid[row][column];

func random_cell():
	var x = rng.randi_range(0, rows-1);
	var y = rng.randi_range(0,columns-1);
	
	return grid[x][y];
	
func get_area():
	var area;
	area = rows * columns;
	return area;
	
# Implementation pending if needed. see page 22
func each_row():
	pass

# Implementation pending if needed. see page 22
func each_cell():
	pass


func contents_of(cell):
	print(str(cell.distance()));
