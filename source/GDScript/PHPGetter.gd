extends Node

@export var HorseName: Label
@export var HorseLVL: Label
@export var HorseXP: Label
@export var HorseSpeed: Label
@export var HorseIQ: Label
@export var HorseTexture: TextureRect

@export var GrassButton : Button
@export var HayButton : Button
@export var AppleButton : Button
@export var CarrotButton : Button
@export var GoldGrassButton : Button

const url = "http://localhost/test.php"
var httprequest : HTTPRequest = HTTPRequest.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(httprequest)
	httprequest.request_completed.connect(self._RequestComplete)
	_do()

func _do():

	_SendRequest()

func _SendData(data):
	var json = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	
	httprequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _SendRequest():
	var headers = ["Content-Type: application/json"]
	httprequest.request(url, headers, HTTPClient.METHOD_GET)

func _RequestComplete(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var dic = json['response']
	HorseName.text = str(dic['name']).pad_decimals(0)
	HorseLVL.text = "LV: " + str(dic['lvl']).pad_decimals(0)
	HorseXP.text = "XP: " + str(dic['xp']).pad_decimals(0) + "/" + str(dic['lvl'] * 100).pad_decimals(0)
	HorseSpeed.text = "SP: " + str(dic['speed']).pad_decimals(0)
	HorseIQ.text = "IQ: " + str(dic['iq']).pad_decimals(0)
	match dic['color']:
		"Black":
			HorseTexture.texture = load("res://Assets/img/horse_black.png")
		"Brown":
			HorseTexture.texture = load("res://Assets/img/horse_brown.png")
		"White":
			HorseTexture.texture = load("res://Assets/img/horse_white.png")
			
	GrassButton.text = "x" + str(dic['grass']).pad_decimals(0)
	HayButton.text = "x" + str(dic['hay']).pad_decimals(0)
	AppleButton.text = "x" + str(dic['apple']).pad_decimals(0)
	CarrotButton.text = "x" + str(dic['carrot']).pad_decimals(0)
	GoldGrassButton.text = "x" + str(dic['goldGrass']).pad_decimals(0)

		


	
