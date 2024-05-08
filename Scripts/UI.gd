extends Control

@onready var paragrafo = $MarginContainer/Balao/MarginContainer/Fala
@onready var nomeText = $MarginContainer/Balao/MarginContainer2/Nome
@onready var timer = $TimerLetra

var falaCarregada : PackedStringArray
var index = 0
var escrevendo = false
var interromper = false

func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("E") and GameController.playerInteragindo:
		get_viewport().set_input_as_handled()
		proximaFala()

func comecaInteracao(falasNovas, nome):
	if GameController.playerInteragindo: return
	
	print("Comecou interacao")
	nomeText.text = nome
	GameController.playerInteragindo = true
	visible = true
	falaCarregada = falasNovas
	index = 0
	proximaFala()

func proximaFala():
	if index >= falaCarregada.size():
		visible = false
		GameController.playerInteragindo = false
		return
	if escrevendo:
		interromper = true
		return
	
	escrevendo = true
	paragrafo.clear()
	var lendoEfeito = false
	var falaCompleta = ""
	
	for char in falaCarregada[index]:
		if char == '[':
			lendoEfeito = true
		
		falaCompleta += char
		
		if lendoEfeito:
			if char == ']':
				lendoEfeito = false
				paragrafo.text = falaCompleta
			continue
		
		paragrafo.append_text(char)
		timer.start()
		await timer.timeout
		if interromper: 
			paragrafo.text = falaCarregada[index]
			interromper = false
			break
	
	index += 1
	escrevendo = false
