extends Timer


onready var timer = self
onready var timerLabel = $"../GUI/Main/CenterContainer/HBoxContainer/TextTimer"
onready var icoStart:Sprite = $"../GUI/Main/CenterContainer/HBoxContainer/StartPauseButton/IcoStart"
onready var spinBox:SpinBox = $"../GUI/ParamMenu/VBoxContainer/SpinBox"


var initTimerValue = 5 # *60
var isCounting = false
var remaningTime


func init_timer():
	updateTimerText(initTimerValue)
	isCounting = false
	timer.stop()
	remaningTime = initTimerValue
	updatePlayPauseIcon()


func _ready():
	init_timer()


func updateTimerText(time):
	var minutes = floor(time / 60)
	var sec = int(time - 60 * minutes)
	timerLabel.text = str(minutes) + ":" + str(sec).pad_zeros(2)


func _process(delta):
	if isCounting:
		remaningTime = timer.time_left
		updateTimerText(remaningTime)


func updatePlayPauseIcon():
	if isCounting:
		var text:Texture = preload("res://assets/icoPause.png")
		icoStart.set_texture(text)
	else:
		var text:Texture = preload("res://assets/icoStart.png")
		icoStart.set_texture(text)


func exit_focus():
	print_debug("focus exit")
	var lineEdit = spinBox.get_line_edit()
	lineEdit.release_focus()


func _on_SpinBox_value_changed(value):
	initTimerValue = int(value*60)
	init_timer()
	exit_focus()


func _on_ParamMenu_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			exit_focus()


func _on_Timer_timeout():
	isCounting = false
	init_timer()
	Input.vibrate_handheld(500)


func _on_InitButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			print_debug("init timer")
			init_timer()


func _on_StartPauseButton_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			if isCounting:
				print_debug("pause timer")
				isCounting = false
				timer.stop()
				updatePlayPauseIcon()
			else:
				print_debug("start timer")
				isCounting = true
				updatePlayPauseIcon()
				timer.start(remaningTime)
