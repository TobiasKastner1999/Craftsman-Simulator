extends Node3D
var done = false
var is_up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $".".visible == true:
		$Camera3D.current = true


	if Input.is_action_pressed("leftclick") and $".".visible == true and done == false:
		$AnimationPlayer.play("fill")
		$"Root Scene".position.y += 0.002
		
	if Input.is_action_just_released("leftclick") and $".".visible == true:
		$AnimationPlayer.stop()

	if $"Root Scene".position.y >= -16.15:
		done = true
		Global.concrete_filled_roof = true
		DialogueManager.show_example_dialogue_balloon(load("res://dialoguefiles/schlusstext.dialogue"))
		queue_free()
