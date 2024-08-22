extends Node


var attached = null
var relative =	Vector3(0,0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'relative' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attached:
		print(attached.global_transform.origin)
		print(delta)
		self.global_transform.origin = attached.global_transform.origin + delta


func attachTo(other: Node):
	relative = self.global_transform.origin - other.global_transform.origin
	print(relative)
	attached = other


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
