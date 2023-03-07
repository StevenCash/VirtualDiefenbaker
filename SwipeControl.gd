extends ScrollContainer

signal howl
signal bark
signal attack
signal tamo
signal sleep
signal donut
signal wake
signal exit

var awake = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Button2_pressed():
	emit_signal("howl")


func _on_Button_pressed():
	emit_signal("bark")


func _on_Button3_pressed():
	emit_signal("attack")


func _on_Button4_pressed():
	emit_signal("donut")


func _on_Button5_pressed():
	if awake == 0:
		awake = 1
		emit_signal("sleep")
		$HBoxContainer/Button5.text = "Wake Up"
	else:
		awake = 0
		$HBoxContainer/Button5.text = "Sleep"
		emit_signal("wake")


func _on_Button6_pressed():
	emit_signal("tamo")


func _on_Main_sleepstart():
	$HBoxContainer/Button.disabled = not $HBoxContainer/Button.disabled
	$HBoxContainer/Button2.disabled = not $HBoxContainer/Button2.disabled
	$HBoxContainer/Button3.disabled = not $HBoxContainer/Button3.disabled
	$HBoxContainer/Button4.disabled = not $HBoxContainer/Button4.disabled
	$HBoxContainer/Button6.disabled = not $HBoxContainer/Button6.disabled

func _on_Main_sleepend():
	$HBoxContainer/Button.disabled = not $HBoxContainer/Button.disabled
	$HBoxContainer/Button2.disabled = not $HBoxContainer/Button2.disabled
	$HBoxContainer/Button3.disabled = not $HBoxContainer/Button3.disabled
	$HBoxContainer/Button4.disabled = not $HBoxContainer/Button4.disabled
	$HBoxContainer/Button6.disabled = not $HBoxContainer/Button6.disabled


func _on_Button7_pressed():
	emit_signal("exit")
