extends Node2D

signal eat;
signal bathroom;
signal play;
signal medicine;
signal disipline;

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_tree().get_nodes_in_group("pet"):
		connect("eat",node,"eat_event")
		connect("bathroom",node,"bathroom_event")
		connect("play",node,"play_event")
		connect("medicine",node,"medicine_event")
		connect("disipline",node,"disipline_event")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FoodButton_pressed():
	emit_signal("eat")
	pass # Replace with function body.


func _on_PlayButton_pressed():
	emit_signal("play")
	pass # Replace with function body.


func _on_MedicineButton_pressed():
	emit_signal("medicine")
	pass # Replace with function body.


func _on_BathroomButton_pressed():
	emit_signal("bathroom")
	pass # Replace with function body.
