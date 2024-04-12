extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



@onready var neck = $Neck
@onready var camera = $Neck/Camera3D

@onready var raycast = $Neck/Camera3D/RayCast3D
@onready var hold = $Neck/Camera3D/Hold
var hold_object: Object


func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		neck.rotate_y(-event.relative.x * 0.01)
		camera.rotate_x(-event.relative.y * 0.01)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		$MeshInstance3D.rotate_y(-event.relative.x * 0.01)
func _physics_process(delta):

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_pressed("sprint"):
		SPEED = 8
	else:
		SPEED = 5
	#if Input.is_action_pressed("leftclick"):
		#var mousePos = get_viewport().get_mouse_position()
		#var raylength = 100
		#var from = camera.project_ray_origin(mousePos)
		#var to = from + camera.project_ray_normal(mousePos) * raylength
		#var space = get_world_3d().direct_space_state
		#var rayQuery = PhysicsRayQueryParameters3D.new()
		#rayQuery.from = from
		#rayQuery.to = to
		#rayQuery.collide_with_areas = true
		#var result = space.intersect_ray(rayQuery)
		#if result.size()<1:
			#return



	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()