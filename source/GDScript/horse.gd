extends CharacterBody2D


@export var SPEED = 1.0
@export var IQ = 1.0
var MoodCount = 0
var MoodBoost = 1
@export var Sprite : Sprite2D
@export var Player : bool = false
const url = "http://localhost/horse.php"
var httprequest : HTTPRequest = HTTPRequest.new()

func _ready() -> void:
	if Player:
		add_child(httprequest)
		httprequest.request_completed.connect(self._RequestComplete)
		_SendRequest()

	else:
		match randi_range(1, 3):
			1:
				Sprite.texture = load("res://Assets/img/horse_black.png")
				Sprite.flip_h = true
			2:
				Sprite.texture = load("res://Assets/img/horse_brown.png")
			3:
				Sprite.texture = load("res://Assets/img/horse_white.png")
				

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if MoodCount >= 200 * delta:
		_CalculateMood()
		MoodCount = 0
	
	var direction := 1
	if direction:
		velocity.x = direction * (SPEED * 20) * MoodBoost
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 20 * MoodBoost)

	move_and_slide()
	MoodCount = MoodCount + 1 * delta
	
func _CalculateMood():
	MoodBoost = randf_range(clampf(0.5 * (IQ / 75), 0.5, 4), 4)
	
func _RequestComplete(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var dic = json['response']
	match dic['color']:
		"Black":
			Sprite.texture = load("res://Assets/img/horse_black.png")
			Sprite.flip_h = true
		"Brown":
			Sprite.texture = load("res://Assets/img/horse_brown.png")
		"White":
			Sprite.texture = load("res://Assets/img/horse_white.png")
	SPEED = dic['speed']
	IQ = dic['iq']
	
func _SendRequest():
	var headers = ["Content-Type: application/json"]
	httprequest.request(url, headers, HTTPClient.METHOD_GET)
