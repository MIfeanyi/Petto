extends Node2D

signal eat;
signal bathroom;
signal play;
signal medicine;
signal disipline;

func _ready():
	$Pet.connect("eat",self,"eat_event")
	$Pet.connect("bathroom",self,"bathroom_event")
	$Pet.connect("play",self,"play_event")
	$Pet.connect("medicine",self,"medicine_event")
	$Pet.connect("disipline",self,"disipline_event")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$UI/Border.set_self_modulate(Color(rng.randf_range(0,1),rng.randf_range(0,1),rng.randf_range(0,1)))

#func _process(delta):
#	pass

func _on_FoodButton_pressed():
	emit_signal("eat")
	pass # Replace with function body.

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_MedicineButton_pressed():
	emit_signal("medicine")

func _on_BathroomButton_pressed():
	emit_signal("bathroom")

func _on_MuteButton_pressed():
	$GameAudio.stop()
	$UI/MuteButton.visible = false
	$UI/MusicButton.visible = true

func _on_MusicButton_pressed():
	$GameAudio.play()
	$UI/MuteButton.visible = true
	$UI/MusicButton.visible = false
