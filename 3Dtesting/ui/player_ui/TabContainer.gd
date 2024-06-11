extends Control

var isOpen:bool = false
signal opened
signal closed


@onready var check = $checklist
@onready var info_hub_button = $ButtonInfoHub
@onready var checklist_button = $ButtonChecklist
@onready var tab = $TabContainer
@onready var settings = $ButtonSettings
@onready var save = $ButtonSave
@onready var load = $ButtonLoad
@onready var main_menu = $ButtonMainMenu
@onready var quit = $ButtonQuit




func _ready():
	#close()
	#$"TabContainer/1/MaurerText".append_text("[color=#ffff00]this text is white[/color]")
	pass



#sets the checkmarks of the checklist
func _process(delta):
	if Global.tutorial_finished == true:
		$Panel.visible = false
		
	if Global.tutorial_finished == true:
		check.check_state_1 = true
	if Global.concrete_mixed == true:
		check.check_state_2 = true
	if Global.string == true:
		check.check_state_3 = true
	if Global.wall_finished == true:
		check.check_state_4 = true
	if Global.door_top == 4 and Global.window_top == 0:
		check.check_state_5 = true
	if Global.roof_finished == true:
		check.check_state_6 = true

	
	#sets the open/closemechanic on the escape button
	if Input.is_action_just_pressed("escape"):
		if isOpen == true:
			isOpen = false
			closed.emit()
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			isOpen = true
			opened.emit()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func open():
	tab.visible = true
	isOpen = true
	opened.emit()

func close():
	tab.visible = false
	isOpen = false
	closed.emit()

func _on_button_info_hub_pressed():
	Music._play_button()
	if isOpen == true:
		close()
		info_hub_button.visible = false
		checklist_button.visible = false
		settings.visible = false
		save.visible = false
		load.visible = false
		main_menu.visible = false
		quit.visible = false
	else:
		open()

func _on_button_checklist_pressed():
	Music._play_button()
	if check.visible == false:
		check.visible = true
	else:
		check.visible = false





func _on_button_main_menu_pressed():
	Music._play_button()
	Music._stop_bricklayer()
	$Transition._change_scene("res://ui/screens/titlescreen.tscn")
	close()
	

func _on_button_save_pressed():
	Music._play_button()
	Global.save()

func _on_button_load_pressed():
	Music._play_button()
	Global.load_save()
	if Global.current_scene == 1:
		$Transition._change_scene("res://scenes/CorePlayable/CorePlayable.tscn")
	elif Global.current_scene == 2:
		$Transition._change_scene("res://scenes/StuckateurScene/Stuckateur.tscn")

func _on_button_settings_pressed():
	Music._play_button()
	$Control.visible = true


func _on_button_quit_pressed():
	Music._play_button()
	get_tree().quit()








func _on_close_button_pressed():
	$Job_Buch_Open.hide()
	$Job_Buch.show()
	$Setting_Button.show()
	$Quit_Button.show()
	$checklist.show()

func _on_elektriker_button_pressed():
	if $Job_Buch_Open/MaurerLogbuch.visible == true:
		$Job_Buch_Open/MaurerLogbuch.hide()
		$Job_Buch_Open/ComingSoon.show()


func _on_maurer_button_pressed():
	if $Job_Buch_Open/ComingSoon.visible == true:
		$Job_Buch_Open/ComingSoon.hide()
		$Job_Buch_Open/MaurerLogbuch.show()


func _on_zimmermann_button_pressed():
	if $Job_Buch_Open/MaurerLogbuch.visible == true:
		$Job_Buch_Open/MaurerLogbuch.hide()
		$Job_Buch_Open/ComingSoon.show()


func _on_log_buch_open_button_pressed():
	$Job_Buch_Closed.hide()
	$Job_Buch_Open.show()
	


func _on_job_buch_pressed():
	$Job_Buch_Closed.show()
	$Job_Buch.hide()
	$Setting_Button.hide()
	$Quit_Button.hide()
	$checklist.hide()
	
func _on_quit_button_pressed():
	get_tree().quit()


func _on_setting_button_pressed():
	$Control.visible = true
