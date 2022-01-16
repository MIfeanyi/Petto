extends Node2D

#TODO: LOAD SPRITES VIA EXPORTED FRAMES ONREADY
enum LIFE_STAGES {EGG, BABY, KID, ADULT, DEAD}

var health = 15
var hunger = 10

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
			$Sprites/FoodSprite.set_animation("pizza")
			pass
		LIFE_STAGES.ADULT:
			$Sprites/FoodSprite.set_animation("beer")
			pass
	play_animation($Sprites/FoodSprite,"Food")
	health+=1
	hunger+=5

func play_event():
	match current_life_stage:
		LIFE_STAGES.EGG:
			return #eggs don't play!
			pass
		LIFE_STAGES.BABY:
			$Sprites/ActionSprite.set_animation("ball-action")
			pass
		LIFE_STAGES.KID:
			$Sprites/ActionSprite.set_animation("game-action")
			pass
		LIFE_STAGES.ADULT:
			$Sprites/ActionSprite.set_animation("game-action")
			pass
	play_action_animation()
	hunger-=2
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
		_:
			play_animation($Sprites/PetSprite,"Bathroom")
			pass
	pass
func disipline_event(): #TODO
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
	health+=1
	print(anim_name, " finished")
	if anim_name == "Bathroom":
		$Sprites/BathroomSprite.play("default")


func _on_GrowthTimer_timeout():
	if current_life_stage !=  LIFE_STAGES.ADULT:
		match current_life_stage:
			LIFE_STAGES.EGG:
				current_life_stage = LIFE_STAGES.BABY
				$Sprites/PetSprite.play("baby_idle")
				return
			LIFE_STAGES.BABY:
				$Sprites/PetSprite.play("kid_idle")
				current_life_stage = LIFE_STAGES.KID
				return
			LIFE_STAGES.KID:
				$Sprites/PetSprite.play("adult_idle")
				current_life_stage = LIFE_STAGES.ADULT
				pass
			LIFE_STAGES.ADULT:
				return #TODO: Add death?
	$SFX/GrowAudio.play()


func _on_BathroomTimer_timeout():
	$Sprites/BathroomSprite.play("poop")
	$SFX/BathroomAudio.play()
	health-=1
	pass # Replace with function body.


func _on_HungerTimer_timeout():
	hunger-=1
	if hunger <0:
		health-=hunger
	pass # Replace with function body.


func _on_SickTimer_timeout():
	health -= 2
	$SFX/HitAudio.play()
	pass # Replace with function body.


func _on_HealthTimer_timeout():
	if health < 3:
		$Sprites/EmoteSprite.play("death")
		$SFX/HitAudio.play()
	if health <= 0:
		$Sprites/PetSprite.play("death")
		$SFX/DeathAudio.play()
	if health > 30:
		$Sprites/EmoteSprite.play("help")
	if health > 5 and health < 20:
		$Sprites/EmoteSprite.play("idle")
	if hunger > 20:
		health-=2 #overweight
