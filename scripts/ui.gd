extends Node
@onready var deathui =  get_node("/root/Main/CanvasLayer/deathcontrol")
@onready var endui =  get_node("/root/Main/CanvasLayer3/Control")
@onready var player =  get_node("/root/Main/CharacterBody3D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.death:
		deathui.visible = true

	if player.end:
		if Input.is_action_pressed("end"):
			endui.visible = true

		



	


func _on_button_button_up() -> void:
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 


func _on_retry_button_up() -> void:
	deathui.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
