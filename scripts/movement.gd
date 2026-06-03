extends CharacterBody3D
@onready var camera = $CollisionShape3D/CSGCylinder3D/Head/Camera3D
@onready var head = $CollisionShape3D/CSGCylinder3D/Head
@onready var wall = get_node("/root/Main/wall")
@onready var wall1 = get_node("/root/Main/wall3")
@onready var wall2 = get_node("/root/Main/wall5")
@onready var wall3 = get_node("/root/Main/wall6")
@onready var wall4 = get_node("/root/Main/wall7")
@onready var wall6 = get_node("/root/Main/wall9")
@onready var sphere = get_node("/root/Main/CSGSphere3D2")
@onready var platform =  get_node("/root/Main/wall4")
@onready var col =  get_node("/root/Main/Area3D")

var death = false
var speed = 5
var sprintspeed = 10
var walkspeed = 5
var walljump = false
const mouse = 0.003
var jump = false
var wallnormal = Vector3.ZERO
var crouch = false
var headheight: float = 0.965
var crouchtimer: float = 0.0
var target = headheight
var onplatform = false
var dash = false
var fly = false
var end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == self:
		dash = true # Replace with function body

func _on_area_3d_body_exited(body: Node3D) -> void:
	dash = false # Replace with function body.

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body == self:
		fly = false
		end = true# Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	



	
	var forward = -camera.global_transform.basis.z

	forward = forward.normalized()
	walljump = false
	



	
	var input_dir = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("forward","backward")
		)

	var direction = (camera.global_transform.basis * Vector3(input_dir.x, 0,input_dir.y)).normalized()
	direction.y = 0
	direction = direction.normalized()
	
	if Input.is_action_pressed("sprint"):
		speed = sprintspeed
	else:
		speed =  walkspeed
	
	if direction!= Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 5.0)
		velocity.z = move_toward(velocity.z, 0, 5.0)
	
		
	
	if Input.is_action_pressed("crouch"):
		crouch = true
	else:
		crouch = false	

		
	
	if crouch:
		target = headheight - 0.6
		speed = 8
		scale.y = 0.5

	
	if not crouch:
		target = headheight
		scale.y = 1

	
	head.position.y = lerp(head.position.y, target, 10 * delta)
	
	if onplatform:
 		
		position.z = lerp(position.z, platform.position.z, 6 * delta)
	
	
	if not is_on_floor():
		velocity.y -= 9.8 * delta 
	

	
	onplatform = false
	
	if position.y <= -10:
		position.x = -27
		position.y = 3
		position.z = 35
		death = true
	else:
		death = false
	
	if dash:
		if Input.is_action_pressed("dash"):
			velocity = forward * 175
			velocity.y = 10 
	
	if fly:
		velocity.x = forward.x * 25
		velocity.z = forward.z * 25
		velocity.y = forward.y * 25

	
	move_and_slide()
 
	


	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var obj = collision.get_collider()

		
		if obj == platform:
			onplatform = true
		
		if obj == sphere:
			fly = true
			
		
		if obj == wall:
			walljump = true
			wallnormal = collision.get_normal()
					
		if obj == wall1:
			walljump = true
			wallnormal = collision.get_normal()
			
		if obj == wall2:
			walljump = true
			wallnormal = collision.get_normal()
			
		if obj == wall3:
			walljump = true
			wallnormal = collision.get_normal()
			
		if obj == wall4:
			walljump = true
			wallnormal = collision.get_normal()
			
			
		if obj == wall6:
			walljump = true
			wallnormal = collision.get_normal()
		
		

			

				
				
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += 5
	else:
		pass
		
	if Input.is_action_just_pressed("jump") and walljump:
		velocity.y += 3
		velocity += wallnormal * 6		
	else:
		pass
	
func _input(event) -> void:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x * mouse
			head.rotation.x -= event.relative.y * mouse
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))

  

		
		if event.is_action_pressed("ui_cancel"):
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



	


func _on_button_pressed() -> void:
	pass # Replace with function body.
