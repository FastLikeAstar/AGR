extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN];

var position = Vector2.ZERO;
var direction = Vector2.RIGHT;
var borders = Rect2();
var step_history = [];
var steps_since_turn = 0;
var change_direction_bias = 0.25; #equal chance.
var max_turn_duration = 5;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position));
	position = starting_position;
	step_history.append(position);
	borders = new_borders;
	
func walk(steps):
	for step in steps:
		if randf() <= change_direction_bias or steps_since_turn >= max_turn_duration:
			change_direction();
		
		if step():
			step_history.append(position)
		else:
			change_direction();
	return step_history;
	
func step():
	var target_position = position + direction;
	if borders.has_point(target_position):
		steps_since_turn += 1;
		position = target_position;
		return true;
	else:
		return false;
		
func change_direction():
	steps_since_turn = 0;
	var directions = DIRECTIONS.duplicate();
	directions.erase(direction);
	directions.shuffle();
	direction = directions.pop_front();
	while not borders.has_point(position + direction):
		direction = directions.pop_front();
		
