extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.

func show_message(text):
	$Message.text = text
	print(text)
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# 等待一个时间间隔
	await $MessageTimer.timeout
	
	# 初始化UI
	$Message.text = "Dodge the\nCreeps!"
	#show_message("Dodge the\nCreeps!")
	$Message.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func _on_message_timer_timeout():
	$Message.hide()
