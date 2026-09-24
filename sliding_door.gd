extends MeshInstance3D

var is_open = false
var closed_position: Vector3
var open_position: Vector3
var tween: Tween # Store the tween so we can interrupt it

func _ready():
    closed_position = position
    open_position = closed_position + Vector3(2.5, 0, 0)

# 1. Connect your Area3D's "body_entered" signal to this function
func _on_area_3d_body_entered(body):
    if body.is_in_group("Player"):
        open_door()

# 2. Connect your Area3D's "body_exited" signal to this function
func _on_area_3d_body_exited(body):
    if body.is_in_group("Player"):
        close_door()

func open_door():
    if is_open: return
    is_open = true
    animate_door(open_position)

func close_door():
    if not is_open: return
    is_open = false
    animate_door(closed_position)

func animate_door(target_position: Vector3):
    # Kill the previous tween if the player rapidly enters/exits the zone
    if tween:
        tween.kill() 
        
    tween = get_tree().create_tween()
    tween.tween_property(self, "position", target_position, 1.0)