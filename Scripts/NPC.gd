extends Node2D

@export var nome : String
@export var falas : PackedStringArray

func _ready():
	set_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("E") and !GameController.playerInteragindo:
		print("Interagindo com " + name)
		var ui = %UI
		ui.comecaInteracao(falas, nome)


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		set_process_unhandled_input(true)
	pass # Replace with function body.

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		set_process_unhandled_input(false)
	pass # Replace with function body.
