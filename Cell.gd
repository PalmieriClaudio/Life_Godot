extends ColorRect

class_name Cell

var isAlive = false
var isMouseOver = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.color = Color.WHITE if isAlive else Color.BLACK

func _input(event):
	if event is InputEventMouseButton and event.pressed and isMouseOver:
		isAlive = not isAlive
		
func _on_area_2d_mouse_entered():
	isMouseOver = true

func _on_area_2d_mouse_exited():
	isMouseOver = false
