extends Node2D

@onready var ship := $Ship
@onready var shipControl := $ShipControl/ShipControlPane

func _on_ship_speed_updated(speed):
	ship.speed = speed
