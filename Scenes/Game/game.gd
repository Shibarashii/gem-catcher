extends Node2D

class_name Game
const GEM = preload("uid://uyqw1u30qffg")
const MARGIN: float = 70.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var paddle: Paddle = $Paddle
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var music: AudioStreamPlayer = $Music
@onready var score_label: Label = $ScoreLabel

static var vp_r: Rect2
var _score: int = 0
var _gem_count: int = 0
 
static func get_vpr() -> Rect2:
	return vp_r

func _init() -> void:
	print("Game:: _init")
	
func _enter_tree() -> void:
	print("Game:: _enter_tree")
	
func _ready() -> void:
	print("Game:: _ready")
	update_vp()
	get_viewport().size_changed.connect(update_vp)
	spawn_gem()

func update_vp() -> void:
	vp_r = get_viewport_rect()
	
func _process(_delta: float) -> void:
	spawn_timer.wait_time = randf_range(0.5, 3)
	
func generate_random_position() -> float:
	var random_x = randf_range(
		get_viewport_rect().position.x + MARGIN, 
		get_viewport_rect().end.x - MARGIN)
	return random_x
	
func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var multiplier_steps = floor(_gem_count	 / 5.0)
	var speed_multiplier = pow(1.3, multiplier_steps)
	new_gem.fall_speed *= speed_multiplier

	var x_pos: float = generate_random_position()
	new_gem.position = Vector2(x_pos, -20)
	new_gem.gem_off_screen.connect(_on_gem_off_screen)
	add_child(new_gem)
	_gem_count += 1
	
func stop_all() -> void:
	spawn_timer.stop()
	music.stop()
	score_sound.play()
	paddle.set_process(false)

	for child in get_children():
		if child is Gem:
			child.set_process(false)
	
func _on_timer_timeout() -> void:
	spawn_gem()

func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	score_label.text = "%03d" % _score

	score_sound.position = area.position
	score_sound.play()
	
func _on_gem_off_screen() -> void:
	print("GAME OVER")
	stop_all()
