extends Button

@export var Tutorial : Control

# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	Tutorial.queue_free()
