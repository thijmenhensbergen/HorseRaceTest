extends Control

var url = "http://localhost/store.php"
var httprequest : HTTPRequest = HTTPRequest.new()

var selectedItem : int = 0
@export var Title : Label
@export var Desc : Label
@export var Particle : PackedScene; #drag and drop`
var GrassCart : int
var HayCart : int
var AppleCart : int
var CarrotCart : int
var GoldGrassCart : int
var Money : int
@export var MoneyLabel : Label
@export var BuySFX : AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(httprequest)
	httprequest.request_completed.connect(self._RequestComplete)
	DontAdd()
	SelectGrass()
	
func _SendRequest():
	var headers = ["Content-Type: application/json"]
	httprequest.request(url, headers, HTTPClient.METHOD_GET)
	
func SelectGrass():
	Title.text = "GRASS"
	Desc.text = "It's grass... what more can you say about it. \nGives 10 XP\nOwned: " + str(GrassCart)
	selectedItem = 0
func SelectHay():
	Title.text = "HAY"
	Desc.text = "I got a summer job working in a hay field. \nAfter the first day I baled\nGives 50 XP\nOwned: " + str(HayCart)
	selectedItem = 1
	
func SelectApple():
	Title.text = "APPLE"
	Desc.text = "Doesn't support windows! \nGives 250 XP\nOwned: " + str(AppleCart)
	selectedItem = 2
	
func SelectCarrot():
	Title.text = "CARROT"
	Desc.text = "Improves eyesight! Unfortunately that's not a stat... so you'll have to do with XP\nGives 1250\nXPOwned: " + str(CarrotCart)
	selectedItem = 3
	
func SelectGoldGrass():
	Title.text = "GOLD GRASS"
	Desc.text = "It's a very rare type of grass obtained from the mountains of Shindong China \nGives 5000 XP\nOwned: " + str(GoldGrassCart)
	selectedItem = 4
	
func Add1():
	url = "http://localhost/store.php?f=" + str(selectedItem) + "&c=1"
	_SendRequest()

func add10():
	url = "http://localhost/store.php?f=" + str(selectedItem) + "&c=10"
	_SendRequest()
func add100():
	url = "http://localhost/store.php?f=" + str(selectedItem) + "&c=100"
	_SendRequest()
	BuySFX.play(1.8)
func addMax():
	url = "http://localhost/store.php?f=" + str(selectedItem) + "&c=max"
	_SendRequest()
	BuySFX.play(1.8)
func DontAdd():
	url = "http://localhost/store.php?f=" + str(selectedItem) + "&c=0"
	_SendRequest()
	BuySFX.play(1.8)

func _RequestComplete(result, response_code, headers, body):
	print(response_code)
	print(body.get_string_from_utf8())
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json['error'] == "success":
		var dic = json['response']
		GrassCart = dic['grass']
		HayCart = dic['hay']
		AppleCart = dic['apple']
		CarrotCart = dic['carrot']
		GoldGrassCart = dic['goldGrass']
		Money = dic['money']
		MoneyLabel.text = str(Money)
	elif json['error'] == "oops":
		var tooparticle = Particle.instantiate();	#instantiate
		add_child(tooparticle)
		
		wait(2.5)
		
		tooparticle.queue_free()
	match selectedItem:
		0:
			SelectGrass()
		1:
			SelectHay()
		2:
			SelectApple()
		3:
			SelectCarrot()
		4:
			SelectGoldGrass()
			
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
