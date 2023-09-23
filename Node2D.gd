extends Node2D

@export var cellGridSize = 50

var cell = preload("res://Cell.tscn")
#var cellList : Array[Cell.tscn] = []
var cellList: Array[Cell]= []
var lastCellListState = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(cellGridSize):
		for j in range(cellGridSize):
			var instance = cell.instantiate()
			instance.position = Vector2(j * 40, i * 40)
#			instance.isAlive = true if (i+j) % 2 == 1 else false
			instance.isAlive = false
			cellList.append(instance)
			add_child(instance)

func _process(_delta):
	pass
#	lastCellListState = cellList
#	for i in range(cellList.size()):
#		cellList[i].isAlive = GetNextCellState(i)
#		cellList[i].isAlive = true if i == 3 else false
#		print_debug(GetNextCellState(i))

func GetNextCellState(i) ->  bool:
	#For now just implement that if any 3 neighboring cells are alive, become alive
	var aliveNeighbours = 0
#
	var x = i % cellGridSize
	var y = i / cellGridSize
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			if dx == 0 and dy == 0:
				continue  # Skip the current element
			var new_x = x + dx
			var new_y = y + dy

			if new_x >= 0 and new_x < cellGridSize and new_y >= 0 and new_y < cellGridSize:
				var neighbor_index = new_x + new_y * cellGridSize
				if lastCellListState[neighbor_index] == true:
					aliveNeighbours += 1
	if aliveNeighbours < 2:
		return false
	if aliveNeighbours == 3:
		return true
	if aliveNeighbours > 3:
		return false
	
	return cellList[i].isAlive


func _on_timer_timeout():
	lastCellListState = []
	for cell in cellList:
		lastCellListState.append(cell.isAlive)
	for i in range(cellList.size()):
		cellList[i].isAlive = GetNextCellState(i)
