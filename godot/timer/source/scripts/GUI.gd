extends Control


onready var main = $"Main"
onready var configMenu = $"ConfigMenu"
onready var aboutMenu = $"AboutMenu"
onready var paramMenu = $"ParamMenu"
onready var tween = $"../Tween"


onready var isVisible = {configMenu: false, 
						 aboutMenu : false, 
						 paramMenu : false}
onready var animate = { configMenu: 'V', 
						aboutMenu : 'H', 
						paramMenu : 'H'}
var menuSpeed = 0.15
var initTimerValue = 5 #* 60


func _ready():
	initHidenMenuPositions()


func initHidenMenuPositions():
	if not isVisible[configMenu]:
		configMenu.rect_position= Vector2(0, main.rect_size[1])
	if not isVisible[aboutMenu]:
		aboutMenu.rect_position = Vector2(main.rect_size[0], main.rect_size[1] - aboutMenu.rect_size[1])
	if not isVisible[paramMenu]:
		paramMenu.rect_position = Vector2(main.rect_size[0], main.rect_size[1] - paramMenu.rect_size[1])


func animV(menu, show=true):
	var start
	var end
	if show:
		isVisible[menu] = true
		start = Vector2(0, main.rect_size[1])
		end   = start - Vector2(0, menu.rect_size[1])
	else:
		isVisible[menu] = false
		start = menu.rect_position
		end   = start + Vector2(0, main.rect_size[1])
	if start != end:
		tween.interpolate_property(menu, "rect_position", start, end, menuSpeed)
		tween.start()


func animH(menu, show=true):
	var start
	var end
	if show and isVisible[menu] == false:
		isVisible[menu] = true
		start = main.rect_size - Vector2(0, menu.rect_size[1])
		end   = main.rect_size - menu.rect_size
	elif not show and isVisible[menu] == true:
		isVisible[menu] = false
		start = menu.rect_position
		end   = main.rect_size - Vector2(0, menu.rect_size[1])
	if start != end:
		tween.interpolate_property(menu, "rect_position", start, end, menuSpeed)
		tween.start()


func show_menu(current_menu):
	for menu in isVisible:
		var direction
		if menu == current_menu:
			direction = true
		else:
			direction = false
		
		if animate[menu] == 'H':
			animH(menu, direction)
		else:
			animV(menu, direction)


func _on_ConfigButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			show_menu(configMenu)


func _on_Main_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			show_menu(null)


func _on_BackButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			show_menu(null)


func _on_AboutButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			show_menu(aboutMenu)


func _on_ParamButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			show_menu(paramMenu)

