extends Label

var time_elapsed := 0.0

var counter = 1
var is_stopped := false


func _process(delta: float) -> void:
	if not Global.in_tutorial:
		Global.timer += delta
		text = str(Global.timer).pad_decimals(2)
