extends AnimatableBody3D

var closed_position: Vector3
var open_position: Vector3
var is_open: bool = false

func _ready() -> void:
	# Automatically save exactly where you placed the door in the editor
	closed_position = position
	
	# Set it to slide sideways on the X-axis by 2 meters (adjust as needed)
	open_position = closed_position + Vector3(2.0, 0, 0)

func _on_door_detect_body_entered(body: Node3D) -> void:
	print("TRIPPED BY: ", body.name)
	if body.name == "Hero":
		open_door()

func _on_door_detect_body_exited(body: Node3D) -> void:
	if body.name == "Hero":
		close_door()

func open_door() -> void:
	if not is_open:
		is_open = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", open_position, 1.2).set_trans(Tween.TRANS_SINE)

func close_door() -> void:
	if is_open:
		is_open = false
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", closed_position, 1.2).set_trans(Tween.TRANS_SINE)
