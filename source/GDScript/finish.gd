extends Control

@export var labelA : Label
@export var LabelB : Label
var url = "http://localhost/finish.php"
var httprequest : HTTPRequest = HTTPRequest.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(httprequest)

func Do(i, g):
	labelA.text = "YOU PLACED " + str(i) + "th"
	LabelB.text = "EARNED " + str(g) + " DOLLARS"
	url = "http://localhost/finish.php?g=" + str(g)
	_SendRequest()
	
func _SendRequest():
	var headers = ["Content-Type: application/json"]
	httprequest.request(url, headers, HTTPClient.METHOD_GET)
	
