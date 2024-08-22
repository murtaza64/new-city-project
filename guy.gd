extends CharacterBody2D

@export var speed = 500
var block = null
var holding = null
var direction = "right"
# map of direction to Vector2
var dir_map = {
	"right": Vector2(1, 0),
	"left": Vector2(-1, 0),
	"up": Vector2(0, -1),
	"down": Vector2(0, 1)
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	block = get_parent().get_node("block")

func move(delta: float) -> void:
	$animation.animation = direction
	$animation.play()
	var movement_vector = dir_map[direction] * speed * delta
	move_and_collide(movement_vector)

func _process(delta: float) -> void:
	if holding != null:
		var offset = null
		offset = dir_map[direction] * 32
		holding.position = position + offset

	if Input.is_action_pressed("move_right"):
		direction = "right"
		move(delta)
	elif Input.is_action_pressed("move_left"):
		direction = "left"
		move(delta)
	elif Input.is_action_pressed("move_up"):
		direction = "up"
		move(delta)
	elif Input.is_action_pressed("move_down"):
		direction = "down"
		move(delta)
	else:
		# stop animation and go to first frame
		$animation.stop()
		$animation.frame = 0


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		print("EEEEE")
		if holding == null:
			var distance = position.distance_to(block.position)
			print(distance)
			# check distance from block
			if distance < 120:
				block.get_node("CollisionShape2D").disabled = true
				holding = block
		else:
			holding = null
			block.get_node("CollisionShape2D").disabled = false
