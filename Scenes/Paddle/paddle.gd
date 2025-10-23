extends Area2D

class_name Paddle

@export var move_speed: float = 1000.0


func _init() -> void:
	print("Paddle:: _init")
	
func _enter_tree() -> void:
	print("Paddle:: _enter_tree")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Paddle:: _ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement: float = Input.get_axis("move_left", "move_right")
	position.x += move_speed * movement * delta

	position.x = clampf(position.x, Game.get_vpr().position.x, Game.get_vpr().end.x)


func _on_area_entered(_area: Area2D) -> void:
	pass
