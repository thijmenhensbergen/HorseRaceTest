extends TextureButton

@export var Scene : PackedScene
@export var Daddy : Control
# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	var node = Scene.instantiate()
	Daddy.add_child(node)
