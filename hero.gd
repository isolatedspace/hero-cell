extends CharacterBody3D

@export var speed: float = 5.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
    # 1. Apply gravity to keep the character anchored to the floor
    if not is_on_floor():
        velocity.y -= gravity * delta

    # 2. Get the directional input from your mapped WASD keys
    var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    
    # 3. Translate that 2D input into 3D space (moving on the X and Z axes)
    var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
    
    # 4. Apply speed to the movement direction
    if direction:
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed
    else:
        # Stop instantly when keys are released to maintain precise control
        velocity.x = move_toward(velocity.x, 0, speed)
        velocity.z = move_toward(velocity.z, 0, speed)

    # 5. Execute the movement and handle any collisions
    move_and_slide()