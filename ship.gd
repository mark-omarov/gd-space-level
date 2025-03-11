extends Sprite2D

var normal_speed := 500.0
var boost_speed := 900.0
var max_speed := normal_speed
var velocity := Vector2.ZERO
var velocity_factor := 10.0
var l_thruster

func _ready() -> void:
	pass
	#get_node("LeftThruster").hide()
	#get_node("RightThruster").hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		get_node("Timer").start()
		
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	
	var desired_velocity := direction * max_speed
	var steering_vector := desired_velocity - velocity
	var steering_amount := velocity_factor * delta
	
	if steering_amount > 1.0:
		steering_amount = 1.0
	
	velocity += steering_vector * steering_amount
	position += velocity * delta
	
	if velocity.length() > 0.0:
		rotation = velocity.angle() + PI / 2
		
	var l_thruster := get_node("LeftThruster")
	var r_thruster := get_node("RightThruster")

	if direction.length() > 0.0:
		l_thruster.show()
		r_thruster.show()
	else:
		l_thruster.hide()
		r_thruster.hide()

func _on_timer_timeout() -> void:
	max_speed = normal_speed
