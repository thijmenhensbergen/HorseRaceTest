extends Button

@export var url = "http://localhost/feed.php?c=10"
var httprequest : HTTPRequest = HTTPRequest.new()
@export var PHPManager : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(httprequest)
	httprequest.request_completed.connect(self._RequestComplete)
	pressed.connect(_button_pressed)



func _button_pressed():
	var headers = ["Content-Type: application/json"]
	httprequest.request(url, headers, HTTPClient.METHOD_GET)
	
func _RequestComplete(result, response_code, headers, body):
	PHPManager._do()
