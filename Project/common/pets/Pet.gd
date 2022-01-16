extends Node2D

#TODO: LOAD SPRITES VIA EXPORTED FRAMES ONREADY
enum LIFE_STAGES {EGG, BABY, KID, ADULT}

var health = 5
var hunger = 5

var current_life_stage = LIFE_STAGES.EGG
# Called when the node enters the scene tree for the first time.
func _ready():
	#connect("eat",self,"eat_event")
	pass # Replace with function body.
func play_action_animation():
	$Sprites/ActionSprite.visible = true
	$AnimationPlayer.play("Play Animation")
func play_animation(sprite,anim_name):
	sprite.visible = true
	$AnimationPlayer.play(anim_name)
	pass
func eat_event():
	match current_life_stage:
		LIFE_STAGES.EGG:
			return #eggs don't play!
			pass
		LIFE_STAGES.BABY:
			$Sprites/FoodSprite.set_animation("bottle")
			pass
		LIFE_STAGES.KID:
			pass
		LIFE_STAGES.ADULT:
			pass
	play_animation($Sprites/FoodSprite,"Food")

func play_event():
	match current_life_stage:
		LIFE_STAGES.EGG:
			return #eggs don't play!
			pass
		LIFE_STAGES.BABY:
			$Sprites/ActionSprite.set_animation("ball-action")
			pass
		LIFE_STAGES.KID:
			pass
		LIFE_STAGES.ADULT:
			pass
	play_action_animation()
	pass
func medicine_event():
	match current_life_stage:
		LIFE_STAGES.EGG:
			return
		_:
			$Sprites/ActionSprite.set_animation("shot-action")
			play_action_animation()
	pass
func bathroom_event():
	match current_life_stage:
		LIFE_STAGES.EGG:
			return #eggs don't play!
			pass
		LIFE_STAGES.BABY:
			pass
		LIFE_STAGES.KID:
			pass
		LIFE_STAGES.ADULT:
			pass
	pass
func disipline_event():
	match current_life_stage:
		LIFE_STAGES.EGG:
			return #eggs don't play!
			pass
		LIFE_STAGES.BABY:
			pass
		LIFE_STAGES.KID:
			pass
		LIFE_STAGES.ADULT:
			pass
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	$Sprites/FoodSprite.visible = false
	$Sprites/ActionSprite.visible = false
	pass # Replace with function body.


func _on_GrowthTimer_timeout():
	if current_life_stage !=  LIFE_STAGES.ADULT:
		match current_life_stage:
			LIFE_STAGES.EGG:
				current_life_stage = LIFE_STAGES.BABY
				$Sprites/PetSprite.play("baby_idle")
				return
			LIFE_STAGES.BABY:
				pass
			LIFE_STAGES.KID:
				pass
			LIFE_STAGES.ADULT:
				pass
	pass # Replace with function body.


func _on_BathroomTimer_timeout():
	#shit
	pass # Replace with function body.


func _on_HungerTimer_timeout():
	hunger-=1
	pass # Replace with function body.


func _on_SickTimer_timeout():
	health -= 2
	pass # Replace with function body.
