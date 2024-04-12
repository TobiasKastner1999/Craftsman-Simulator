extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var lastLook :Vector3
var lookat = Vector3(0,0,0)
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("right", "left", "back", "forward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#var lerpdir = lerp(lastLook,Vector3(lookat.global_position.x, lookat.global_position.y, lookat.global.z),1 )
		look_at(direction)
		lastLook = direction
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	$AnimationTree.set("parameters/conditions/idle", input_dir == Vector2.ZERO)
	$AnimationTree.set("parameters/conditions/walk", input_dir != Vector2.ZERO )
	
	move_and_slide()
