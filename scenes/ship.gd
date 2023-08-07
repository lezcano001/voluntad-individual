extends CharacterBody2D

# Should be updated the particles of water to less when the speed is reduced

@onready var arrowSprite := $Arrow
#@onready var shipSprite := $Sprite2D
@onready var arrowNode := $arrowNode

const PARTICLES: PackedScene = preload("res://scenes/water_particle.tscn")


func _ready():
	Input.mouse_mode = 1

#@onready var anim := $AnimationPlayer
var shipDirection
@onready var shipSprite := $Sprite2D

var collectableTrash: Array = []

func _input(event):
	if Input.is_action_just_pressed("generic_player_action"):
		# Most higher priority action
		if collectableTrash.size() > 0:
			var deletedTrash = collectableTrash.pop_back()
			
			# agregar peso al barco
			
			deletedTrash.call_deferred("queue_free")

func _physics_process(delta):
	arrowNode.look_at(get_global_mouse_position())
	
	# This is for make the mouse tolerate the rotation of the medium
	var cicles = int(floor((arrowNode.rotation_degrees + 11.25) / 22.5)) + 4
	
	var animation = ((cicles % 16) * -1 + 16) % 16
	
#	print(animation)
	
	# Add a lerp to delay the transition between the initial state and the end state
	shipDirection = Vector2(0, -1).rotated(-1 * deg_to_rad(animation * 22.5))
	
#	print(shipDirection)
	
	move(delta)
	instanceParticles(animation * 22.5 + 11.25, (animation + 1) * 40)
	shipSprite.frame = animation
#	animate()

#const MAX_SPEED := 400.0
var speed := 0
var interpolation_factor: float

# original speed - to - final speed

# when reducing the speed apply a linear interpolation

func move(delta):
#	directionX = Input.get_axis("left", "right")
#	directionY = Input.get_axis("forward", "backward")
	
#	if Vector2(directionX, directionY) != Vector2.ZERO:
#		pass
#		interpolation_factor = 0.0
#		velocity.x = directionX * speed
#		velocity.y = directionY * speed
#	else:
#		interpolation_factor = clamp(interpolation_factor + delta * 0.05, 0.0, 1.0)
#		velocity = lerp(velocity, Vector2(directionX * speed, ), interpolation_factor)
	# result = floor(rotation / 22.5)
	# result % 16
	velocity = shipDirection * speed
	move_and_slide()

#func animate():
#	if Vector2(directionX, directionY) == Vector2.ZERO:
#		return

#	anim.play(DIRECTIONS[Vector2(directionX,directionY)])

func instanceParticles(start, end):
	var particle = PARTICLES.instantiate()
	
	particle.z_index = 0
	
	get_tree().root.call_deferred("add_child", particle)
	
	var multiplicationFactor = randi_range(start, end)
	
	particle.global_position = global_position + Vector2(0, 20).rotated(deg_to_rad(multiplicationFactor))


func _on_area_2d_body_entered(body):
	if body.is_in_group("trash"):
		collectableTrash.append(body)
		print(collectableTrash)


func _on_area_2d_body_exited(body):
	if body.is_in_group("trash"):
		collectableTrash.filter(func(instance): instance != body)
