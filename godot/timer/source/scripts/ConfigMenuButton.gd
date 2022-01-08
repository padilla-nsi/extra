extends ColorRect


export var icon: Texture
export var texte: String
export var overColor:Color = Color("d94bc9")
export var fontColor:Color = Color("631b6e")


func _ready():
	$"HBoxContainer/Ico/IcoParam".texture = icon
	$"HBoxContainer/Label".text = texte


func _on_ParamButton_mouse_entered():
	self.color = overColor


func _on_ParamButton_mouse_exited():
	self.color = fontColor
