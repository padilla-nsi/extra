extends ColorRect


export var icon:Texture
export var fontColor:Color = Color("631b6e")
export var overColor:Color = Color("d94bc9")


func _ready():
	$"Icon".texture = icon
	$"Icon".position = self.rect_size / 2
	self.color = fontColor


func _on_IconButton_mouse_entered():
	self.color = overColor

func _on_IconButton_mouse_exited():
	self.color = fontColor
