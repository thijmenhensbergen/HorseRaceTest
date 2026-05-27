extends Node2D

@export var Collision : CollisionShape2D
@export var HorsePositions : Array[CharacterBody2D]
@export var Area : Area2D
@export var Canva : CanvasLayer
var FinishHorses : Array[Node2D]
var FinishedBefore : bool = false

@export var Reward : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await wait(4)
	print("yeah")
	Collision.set_deferred("disabled", true)
	
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

#func _physics_process(delta: float) -> void:
#	HorsePositions.sort()
#	HorsePositions.reverse()


func _on_finishline_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	FinishHorses = Area.get_overlapping_bodies()
	print(FinishHorses)
	for i in len(FinishHorses):
		var unit = FinishHorses[i]
		if unit.name == "PlayerHorse":
			print("Player placed" + str(i + 1) + " st")
			Finish(i + 1)
		
func Finish(i):
	if FinishedBefore == false:
		FinishedBefore = true # avoid triggering finish twice.
		var scene = preload("res://Assets/Scenes/Finish.tscn").instantiate()
		Canva.add_child(scene)
		Reward /= i
		scene.Do(i, Reward)
		
