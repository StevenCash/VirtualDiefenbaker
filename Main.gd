extends Spatial

onready var Dief = $KinematicBody
onready var joystick = $CanvasLayer/Joystick
const donut = preload ("res://donutbody.tscn")

var speed = 15
var velocity = Vector3 (0,0,0)
var vel2d = Vector2 (0,0)
var idle2d = Vector2 (0,0)
var diefangle = 0
var diefspeed = 0
var howl = 0
var sleep = 0
var food

signal sleepstart
signal sleepend


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	vel2d = joystick.get_velo()
	if abs(vel2d.x) < .0001:
		vel2d.x = 0
	if abs(vel2d.y) < .0001:
		vel2d.y = 0
	velocity.x = vel2d.x
	velocity.z = vel2d.y
	diefspeed = sqrt(vel2d.x*vel2d.x+vel2d.y*vel2d.y)

	if 	$KinematicBody/Husky/AnimationPlayer.current_animation != "Eating" and food != null:
		if is_instance_valid(food):
			food.queue_free()
			food = null
	if $KinematicBody/Husky/AnimationPlayer.current_animation == "Howl":
		pass
	elif $KinematicBody/Husky/AnimationPlayer.current_animation == "Eating":
		pass
	elif $KinematicBody/Husky/AnimationPlayer.current_animation == "Attack":
		pass
	elif $KinematicBody/Husky/AnimationPlayer.current_animation == "Idle_2_HeadLow":
		pass
	elif sleep == 1 and $KinematicBody/Husky/AnimationPlayer.current_animation == "Sleep":
		pass
	elif sleep == 0 and $KinematicBody/Husky/AnimationPlayer.current_animation == "Wake":
		pass
	elif sleep == 1 and $KinematicBody/Husky/AnimationPlayer.current_animation != "Sleep":
		$KinematicBody/Husky/AnimationPlayer.play("Sleeping")
	elif vel2d == idle2d:
		$KinematicBody/Husky/AnimationPlayer.play("Idle_2")
		$KinematicBody/Husky/AnimationPlayer.playback_speed = 1
	else:
		Dief.move_and_slide(velocity*speed)
		if diefspeed < .5:
			$KinematicBody/Husky/AnimationPlayer.play("Walk")
		else:
			$KinematicBody/Husky/AnimationPlayer.play("Gallop")
		diefangle = rad2deg(atan2(vel2d.x,vel2d.y))
		
		if Dief.get_rotation_degrees().y != diefangle:
			#print(diefangle)
			if (abs(diefangle-Dief.get_rotation_degrees().y)) > 300:
				Dief.rotate_y(deg2rad(-1*(diefangle-Dief.get_rotation_degrees().y)/30))
			else:
				Dief.rotate_y(deg2rad((diefangle-Dief.get_rotation_degrees().y)/10))


func _on_SwipeControl_howl():
	$KinematicBody/Husky/AnimationPlayer.play("Howl")
	$Howlsound.play()


func _on_SwipeControl_bark():
	$Barksound.play()


func _on_SwipeControl_sleep():
	sleep = 1
	emit_signal("sleepstart")
	$KinematicBody/Husky/AnimationPlayer.play("Sleep")
	$snoresound.play()


func _on_SwipeControl_wake():
	sleep = 0
	emit_signal("sleepend")
	$KinematicBody/Husky/AnimationPlayer.play("Wake")
	$snoresound.stop()


func _on_SwipeControl_donut():
	print(food)
	if food == null:
		food = donut.instance()
		get_parent().add_child(food)
		#food.global_transform.origin = $KinematicBody/Husky.global_transform.origin + Vector3(0,4,2.5)
		food.global_transform.origin = $KinematicBody/Spatial.global_transform.origin + Vector3(0,5,0)
		$eatsound.play()
		$KinematicBody/Husky/AnimationPlayer.playback_speed = 0.5
		$KinematicBody/Husky/AnimationPlayer.play("Eating")
	else:
		pass


func _on_SwipeControl_attack():
	$KinematicBody/Husky/AnimationPlayer.play("Attack")
	$attacksound.play()


func _on_SwipeControl_tamo():
	$KinematicBody/Husky/AnimationPlayer.play("Idle_2_HeadLow")
	$whimpersound.play()

func _on_SwipeControl_exit():
	get_tree().quit()
