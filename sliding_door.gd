extends MeshInstance3D

var is_open = false
var closed_position: Vector3
var open_position: Vector3

func _ready():
    closed_position = position
    # Calculates the open position by sliding 2.5 meters on the X axis.
    # (Change to Vector3(0, 2.5, 0) if you want a vertical blast door instead!)
    open_position = closed_position + Vector3(2.5, 0, 0)

func _input(event):
    # Temporary test trigger: Pressing the Spacebar
    if event.is_action_pressed("ui_accept"):
        toggle_door()

func toggle_door():
    # Create a Tween to animate the movement smoothly over 1 second
    var tween = get_tree().create_tween()
    
    if is_open:
        tween.tween_property(self, "position", closed_position, 1.0)
    else:
        tween.tween_property(self, "position", open_position, 1.0)
        
    is_open = !is_open