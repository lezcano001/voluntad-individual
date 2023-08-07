extends Control

signal speedUpdated

var sensibility := 100
@onready var velocitySlider := $VelocitySlider
@onready var speedLabel := $TextureRect/VBoxContainer/Label
func _physics_process(delta):
	var difference = Input.get_axis("reduce_velocity", "increase_velocity")
	velocitySlider.value += sensibility * difference * delta
	speedLabel.text = str(velocitySlider.value)

func _on_velocity_slider_value_changed(value):
	speedUpdated.emit(value)
