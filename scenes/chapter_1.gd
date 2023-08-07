extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var ship := $Ship
@onready var shipControl := $ShipControl/ShipControlPane

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Add lerp to update the velocity
func _on_ship_speed_updated(speed):
	ship.speed = speed
