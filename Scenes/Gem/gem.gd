extends Area2D

class_name Gem

@export var fall_speed = 200.0

signal gem_off_screen

func _enter_tree() -> void:
	print("Gem:: _enter_tree")
	
func _ready() -> void:
	print("Gem:: _ready")

func _process(delta: float) -> void:
	position.y += fall_speed * delta
	if position.y > Game.get_vpr().end.y:
		gem_off_screen.emit()
		die()


func die() -> void:
	set_process(false)
	queue_free()
	

func _on_area_entered(_area: Area2D) -> void:
	die()
