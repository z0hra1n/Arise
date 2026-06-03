extends CSGBox3D

var move: float = 0
var mov = false
var velocity: Vector3
var lastpos: Vector3
var delta_motion:  Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	

	
	position.z += move
	


	
	if position.z < -30:
		mov = true

	if position.z > -16:
		mov = false
		
	if mov:
		move = 3 * delta
	
	if not mov:
		move = -3 * delta	
		
	velocity = delta_motion / delta
	
	delta_motion = global_position - lastpos
	lastpos = global_position
