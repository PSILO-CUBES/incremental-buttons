class_name Data_Management extends Node

# bank stuff
@onready var bank_label: Label = $"../BankContainer/Bank"
@onready var bank_gain_label: RichTextLabel = %BankGainLabel

# farm button
@onready var farm_button: Button = $"../GameContainer/LeftContainer/FarmContainer/FarmButton"
@onready var farm_progress_container: Control = $"../GameContainer/LeftContainer/FarmContainer/FarmProgressContainer"
@onready var farm_progress_container_2: Control = $"../GameContainer/LeftContainer/FarmContainer/FarmProgressContainer/FarmProgressContainer2"

# increase click amount
@onready var increment_price_tag: Label = $"../GameContainer/LeftContainer/FarmContainer/ClickIncrementContainer/IncrementPrice"

# progression bar stuff
@onready var progress_bar_container: VBoxContainer = $"../GameContainer/LeftContainer/ProgressBarContainer"

# auto progress bar stuff
@onready var auto_progress_bar_container: HBoxContainer = $"../GameContainer/RightContainer/AutoProgressBarContainer"


# shop stuff

# first button typ shiiiii
@onready var click_multiply_container: Control = $"../GameContainer/LeftContainer/FarmContainer/ClickMultiplyContainer"
@onready var multiply_price_tag := click_multiply_container.get_children()[0]

# click auto progress button
@onready var click_progress_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/ClickProgressButtonContainer"
@onready var click_upgrade_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/ClickUpgradeButtonContainer"

@onready var buy_click_progress_bar_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/ClickProgressBarButtonContainer"
@onready var click_progress_bar_multi_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/ClickProgressBarMultiButtonContainer"

@onready var auto_progress_bar_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/AutoProgressBarButtonContainer"
@onready var auto_progress_bar_speed_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/AutoProgressBarSpeedButtonContainer"
@onready var auto_progress_bar_multi_button_container: Control = $"../GameContainer/LeftContainer/ShopContainer/AutoProgressBarMultiButtonContainer"


# variable wall

@export var click := 0:
	set(value):
		var value_to_print = str(value - click)
		
		if(click <= value && bank_gain_label != null): bank_gain_label.text = "[wave amp=75 freq=12.5]gained " + value_to_print + " [/wave]"
		
		if(value == 999999999999999999): click = 999999999999999999
		else: click = value
		
		if(bank_label != null): 
			set_correct_notation_on_tag(value, bank_label)

@export var click_value := 1:
	set(value):
		click_value = value
		#farm_button.text = 'click for +' + str(value)

@export var increment_upgrade_cost := 1:
	set(value):
		increment_upgrade_cost = value
		set_correct_notation_on_tag(value, increment_price_tag)

@export var multiply_upgrade_cost := 7500:
	set(value):
		multiply_upgrade_cost = value
		set_correct_notation_on_tag(value, multiply_price_tag)

@export var progress_bar_1_value := 0:
	set(value):
		progress_bar_1_value = value
		
		progress_bar_management(progress_bar_container.get_children()[4], progress_bar_1_value, buy_click_progress_bar_info_array[0][3])
		
		if(value >= 100): 
			progress_bar_1_value = 0

@export var progress_bar_2_value := 0:
	set(value):
		progress_bar_2_value = value
		
		progress_bar_management(progress_bar_container.get_children()[3], progress_bar_2_value, buy_click_progress_bar_info_array[1][3])
		
		if(value >= 100): 
			progress_bar_2_value = 0

@export var progress_bar_3_value := 0.0:
	set(value):
		progress_bar_3_value = value
		
		progress_bar_management(progress_bar_container.get_children()[2], progress_bar_3_value, buy_click_progress_bar_info_array[2][3])
		
		if(value >= 100): 
			progress_bar_3_value = 0

@export var progress_bar_4_value := 0.0:
	set(value):
		progress_bar_4_value = value
		
		progress_bar_management(progress_bar_container.get_children()[1], progress_bar_4_value, buy_click_progress_bar_info_array[3][3])
		
		if(value >= 100): 
			progress_bar_4_value = 0

@export var progress_bar_5_value := 0.1:
	set(value):
		progress_bar_5_value = value
		
		progress_bar_management(progress_bar_container.get_children()[0], progress_bar_5_value, buy_click_progress_bar_info_array[0][3])
		
		if(value >= 100): 
			progress_bar_5_value = 0

@export var increment_progress_bar_multi := 1

@export var auto_progress_bar_speed := 1
@export var auto_progress_bar_multi := 1

var gain_currency_pass := false
var toggle_unlocked = false

var buy_click_upgrade_info_array = [
	['multiply', false, 25000000],
	['hold_down', false, 750000000000]
]

var buy_click_progress_button_info_array = [
	[50, false, 500],
	[6850000, false, 500000],
	[574350000, false, 'second button'],
	[4218440000000000, false, 500000000000],
]

var buy_click_progress_bar_info_array = [
	[350, false, 10, 100],
	[75000, false, 5, 1000],
	[1850000, false, 2.5, 10000],
	[2845920000, false, 1, 100000],
	[989421670000, false, 0.1, 1000000],
]

var buy_click_progress_bar_multi_info_array = [
	[685000, false, 100],
	[574350000, false, 1000],
	[42184400000, false, 10000]
]

# gets the data from this array backwards
var buy_auto_progress_bar_info_array = [
	[7512564830000, false, 0, 1, 1000000],
	[89421670000, false, 0, 5, 100000],
	[95650000, false, 0, 10, 10000],
	[250000, false, 0, 25, 1000],
	[5000 , false, 0, 100, 100]
]

var buy_auto_progress_bar_speed_info_array = [
	[6850000, false, 2],
	[574350000, false, 4],
	[42184400000, false, 8],
	[8942167000000, false, 16],
	[751256483000000, false, 32],
]

var buy_auto_progress_bar_multi_info_array = [
	[185000, false, 100],
	[421844000, false, 1000],
	[89421670000, false, 10000],
]

# vvv functions start here vvv

func set_correct_notation_on_tag(value, target) -> void:
	if(value < 100000):
		target.text = str(value)
	elif(value < 10000000):
		target.text = str(value).erase(str(value).length() - 3, 4) + 'K'
	elif(value < 10000000000):
		target.text = str(value).erase(str(value).length() - 6, 7) + 'M'
	elif(value < 10000000000000):
		target.text = str(value).erase(str(value).length() - 9, 10) + 'B'
	elif(value < 10000000000000000):
		target.text = str(value).erase(str(value).length() - 12, 13) + 'T'
	else:
		target.text = str(value).erase(str(value).length() - 15, 16) + 'Q'

func _on_win_button_down() -> void:
	%WinButton.end_game()
	pass # Replace with function body.

# basic farm stuff

# toggles farming on button
func _on_farm_button_down() -> void:
	if(toggle_unlocked): gain_currency_pass = true
	else: gain_currency()

# toggles farming off button
func _on_farm_button_up() -> void:
	gain_currency_pass = false

# gain currency button
func gain_currency() -> void:
	click += click_value
	
	increment_unlocked_progress_bar()

# increase currency gain button
func _on_button_2_button_down() -> void:
	if(click < increment_upgrade_cost): return
	
	click -= increment_upgrade_cost
	increment_upgrade_cost += int(floor(increment_upgrade_cost * 1.5))
	click_value += 1

# multiply currency gain button
func _on_buy_multiply_button_down() -> void:
	if(click < multiply_upgrade_cost): return
	
	click -= multiply_upgrade_cost
	multiply_upgrade_cost += int(floor(multiply_upgrade_cost * 10))
	click_value *= 2


# progress bar stuff

# function that deals with click progress bar progress
func increment_unlocked_progress_bar() -> void:	
	for i in progress_bar_container.get_children().size():
		if(buy_click_progress_bar_info_array[i][1] == true): 
			match i:
				0:
					progress_bar_1_value += buy_click_progress_bar_info_array[i][2]
				1:
					progress_bar_2_value += buy_click_progress_bar_info_array[i][2]
				2:
					progress_bar_3_value += buy_click_progress_bar_info_array[i][2]
				3:
					progress_bar_4_value += buy_click_progress_bar_info_array[i][2]
				4:
					progress_bar_5_value += buy_click_progress_bar_info_array[i][2]

# manages click progress bar progression
func progress_bar_management(progress_bar, value, multi) -> void:
	if(value < 100): progress_bar.value = value
	else: progress_bar.value = 0
	
	if(progress_bar.visible):
		if(value >= 100):
			click += click_value * multi * increment_progress_bar_multi
			print(click_value * multi)
			print(multi)
			#bank_gain_label.text = "[wave amp=50 freq=15]gained " + str( (click_value * multi) + click_value ) + " [/wave]"


# click farm progress

# farm button progress timer start
func _on_farm_progress_button_down() -> void:
	farm_progress_container.get_children()[2].start()

# farm button progress timer timeout
func _on_farm_progress_timer_timeout() -> void:
	click_progress_management(farm_progress_container)

# farm button 2 progress timer start
func _on_farm_progress_button_2_down() -> void:
	farm_progress_container_2.get_children()[2].start()

# farm button 2 progress timer timeout
func _on_farm_progress_timer_2_timeout() -> void:
	click_progress_management(farm_progress_container_2)

func click_progress_management(target) -> void:
	target.get_children()[1].value += 25
	if(target.get_children()[1].value >= 100):
		target.get_children()[1].value = 0
		target.get_children()[2].stop()
		
		var multi = 0
		
		for i in buy_click_progress_button_info_array.size():
			if(buy_click_progress_button_info_array[i][1] != false): 
				if(typeof(buy_click_progress_button_info_array[i][2]) == 2):
					multi = buy_click_progress_button_info_array[i][2]
		
		click += click_value * multi


# auto progress bar stuff

# manage auto progress bar
func auto_progress_bar_management(value, multi) -> void:
	if(value >= 100):
		click += click_value * multi * auto_progress_bar_multi

func _on_auto_progress_bar_value_changed(value: float) -> void:
	auto_progress_bar_management(value, buy_auto_progress_bar_info_array[4][4])

func _on_auto_progress_bar_2_value_changed(value: float) -> void:
	auto_progress_bar_management(value, buy_auto_progress_bar_info_array[3][4])

func _on_auto_progress_bar_3_value_changed(value: float) -> void:
	auto_progress_bar_management(value, buy_auto_progress_bar_info_array[2][4])

func _on_auto_progress_bar_4_value_changed(value: float) -> void:
	auto_progress_bar_management(value, buy_auto_progress_bar_info_array[1][4])

func _on_auto_progress_bar_5_value_changed(value: float) -> void:
	auto_progress_bar_management(value, buy_auto_progress_bar_info_array[0][4])



# shop stuff

# buy upgrades
func _on_click_upgrade_button_down() -> void:
	for i in buy_click_upgrade_info_array.size():
		if(buy_click_upgrade_info_array[i][1] == false):
			match buy_click_upgrade_info_array[i][0]:
				'multiply':
					if(click < buy_click_upgrade_info_array[i][2]): return
					click -= buy_click_upgrade_info_array[0][2]
					
					buy_click_upgrade_info_array[i][1] = true
					click_multiply_container.visible = true
					
					set_correct_notation_on_tag(buy_click_upgrade_info_array[1][2], click_upgrade_button_container.get_children()[0])
					
					click_upgrade_button_container.get_children()[1].text = 'buy hold down'
					break
				'hold_down':
					if(click < buy_click_upgrade_info_array[i][2]): return
					click -= buy_click_upgrade_info_array[i][2]
					
					buy_click_upgrade_info_array[i][1] = true
					toggle_unlocked = true
					
					click_upgrade_button_container.get_children()[0].text = ''
					click_upgrade_button_container.get_children()[1].text = 'bought everything'
					click_upgrade_button_container.get_children()[1].disabled = true
					break

# buy click progress button
func _on_click_progress_button_down() -> void:
	for i in buy_click_progress_button_info_array.size():
		if(buy_click_progress_button_info_array[i][1] == false):
			if(click < buy_click_progress_button_info_array[i][0]): return
			
			click -= buy_click_progress_button_info_array[i][0]
			buy_click_progress_button_info_array[i][1] = true
			farm_progress_container.visible = true
			
			if(i + 1 >= buy_click_progress_button_info_array.size()): 
				click_progress_button_container.get_children()[0].text = ''
				click_progress_button_container.get_children()[1].text = 'bought everything'
				click_progress_button_container.get_children()[1].disabled = true
			else: 
				set_correct_notation_on_tag(buy_click_progress_button_info_array[i + 1][0], click_progress_button_container.get_children()[0])
				if(typeof(buy_click_progress_button_info_array[i + 1][2]) == 2):
					click_progress_button_container.get_children()[1].text = 'upgrade *' + str(buy_click_progress_button_info_array[i + 1][2])
				else:
					click_progress_button_container.get_children()[1].text = 'upgrade ' + str(buy_click_progress_button_info_array[i + 1][2])
					
				if(typeof(buy_click_progress_button_info_array[i][2]) == 4):
					farm_progress_container_2.visible = true
			break

# buy incremental bar on click
func _on_buy_click_progress_bar_button_down() -> void: 
	for i in progress_bar_container.get_children().size():
		if(buy_click_progress_bar_info_array[i][1] == false):
			if(click < buy_click_progress_bar_info_array[i][0]): return
			
			click -= buy_click_progress_bar_info_array[i][0]
			buy_click_progress_bar_info_array[i][1] = true
			progress_bar_container.get_children()[auto_progress_bar_container.get_children().size() - i - 1].visible = true
			$"../GameContainer/LeftContainer/ShopContainer/ClickProgressBarMultiButtonContainer".visible = true
			
			if(i + 1 >= progress_bar_container.get_children().size()): 
				buy_click_progress_bar_button_container.get_children()[0].text = ''
				buy_click_progress_bar_button_container.get_children()[1].text = 'bought everything'
				buy_click_progress_bar_button_container.get_children()[1].disabled = true
			else: 		set_correct_notation_on_tag(buy_click_progress_bar_info_array[i + 1][0], buy_click_progress_bar_button_container.get_children()[0])
			
			break

# buy incremental bar multi on click
func _on_buy_click_progress_bar_multi_button_down() -> void:
	for i in buy_click_progress_bar_multi_info_array.size():
		if(click < buy_click_progress_bar_multi_info_array[i][0] or buy_click_progress_bar_multi_info_array[i][1] == true): continue
		
		click -= buy_click_progress_bar_multi_info_array[i][0]
		increment_progress_bar_multi = buy_click_progress_bar_multi_info_array[i][2]
		
		print(buy_click_progress_bar_multi_info_array[i])
		if(buy_click_progress_bar_multi_info_array[i][1] == true or i + 1 >= buy_click_progress_bar_multi_info_array.size()): 
			click_progress_bar_multi_button_container.get_children()[1].text = 'bought everything'
			click_progress_bar_multi_button_container.get_children()[1].disabled = true
			click_progress_bar_multi_button_container.get_children()[0].text = ''
			continue
		
		set_correct_notation_on_tag(buy_click_progress_bar_multi_info_array[i + 1][0], click_progress_bar_multi_button_container.get_children()[0])
		click_progress_bar_multi_button_container.get_children()[1].text = 'increment bar *' + str(buy_click_progress_bar_multi_info_array[i + 1][2])
		
		buy_click_progress_bar_multi_info_array[i][1] = true
		click_progress_bar_multi_button_container.get_children()[1].disabled = false
		
		break

# buy auto progess bar button
func _on_buy_auto_progress_bar_button_down() -> void:
	for i in auto_progress_bar_container.get_children().size():
		var target = auto_progress_bar_container.get_children().size() - i - 1
		print(click < buy_auto_progress_bar_info_array[target][0])
		if(click < buy_auto_progress_bar_info_array[target][0] or buy_auto_progress_bar_info_array[target][1] == true): continue
		
		click -= buy_auto_progress_bar_info_array[target][0]
		buy_auto_progress_bar_info_array[target][1] = true
		auto_progress_bar_container.get_children()[target].visible = true
		
		$"../GameContainer/LeftContainer/ShopContainer/AutoProgressBarSpeedButtonContainer".visible = true
		$"../GameContainer/LeftContainer/ShopContainer/AutoProgressBarMultiButtonContainer".visible = true
		
		if(i + 1 >= auto_progress_bar_container.get_children().size()): 
			auto_progress_bar_button_container.get_children()[0].text = ''
			auto_progress_bar_button_container.get_children()[1].text = 'bought everything'
			auto_progress_bar_button_container.get_children()[1].disabled = true
		else: set_correct_notation_on_tag(buy_auto_progress_bar_info_array[target - 1][0], auto_progress_bar_button_container.get_children()[0])
		
		break

# buy auto progess speed button
func _on_buy_auto_progress_bar_speed_button_down() -> void:
	for i in buy_auto_progress_bar_speed_info_array.size():
		if(click < buy_auto_progress_bar_speed_info_array[i][0] or buy_auto_progress_bar_speed_info_array[i][1] == true): continue
		
		auto_progress_bar_speed = buy_auto_progress_bar_speed_info_array[i][2]
		
		print(buy_auto_progress_bar_speed_info_array[i])
		if(buy_auto_progress_bar_speed_info_array[i][1] == true or i + 1 >= buy_auto_progress_bar_speed_info_array.size()): 
			auto_progress_bar_speed_button_container.get_children()[1].text = 'bought everything'
			auto_progress_bar_speed_button_container.get_children()[1].disabled = true
			auto_progress_bar_speed_button_container.get_children()[0].text = ''
			continue
		
		set_correct_notation_on_tag(buy_auto_progress_bar_speed_info_array[i + 1][0], auto_progress_bar_speed_button_container.get_children()[0])
		auto_progress_bar_speed_button_container.get_children()[1].text = 'auto speed *' + str(buy_auto_progress_bar_speed_info_array[i + 1][2])
		
		buy_auto_progress_bar_speed_info_array[i][1] = true
		auto_progress_bar_speed_button_container.get_children()[1].disabled = false
		
		break

# buy auto progress multi button -- buy_auto_progress_bar_multi_info_array
func _on_buy_auto_progress_bar_multi_button_down() -> void:
	for i in buy_auto_progress_bar_multi_info_array.size():
		if(click < buy_auto_progress_bar_multi_info_array[i][0] or buy_auto_progress_bar_multi_info_array[i][1] == true): continue
		print(buy_auto_progress_bar_multi_info_array[i][0])
		
		click -= buy_auto_progress_bar_multi_info_array[i][0]
		auto_progress_bar_multi = buy_auto_progress_bar_multi_info_array[i][2]
		
		print(buy_auto_progress_bar_multi_info_array[i])
		if(i + 1 >= buy_auto_progress_bar_multi_info_array.size()): 
			auto_progress_bar_multi_button_container.get_children()[1].text = 'bought everything'
			auto_progress_bar_multi_button_container.get_children()[1].disabled = true
			auto_progress_bar_multi_button_container.get_children()[0].text = ''
			continue
		
		set_correct_notation_on_tag(buy_auto_progress_bar_multi_info_array[i + 1][0], auto_progress_bar_multi_button_container.get_children()[0])
		auto_progress_bar_multi_button_container.get_children()[1].text = 'auto multi *' + str(buy_auto_progress_bar_multi_info_array[i + 1][2])
		buy_auto_progress_bar_multi_info_array[i][1] = true
		auto_progress_bar_multi_button_container.get_children()[1].disabled = false
		
		break

# godot methods

# currency display on load
func _ready() -> void:
	bank_label.text = str(click)
	#farm_button.text = 'click for +' + str(click_value)
	
	set_correct_notation_on_tag(increment_upgrade_cost, increment_price_tag)
	set_correct_notation_on_tag(multiply_upgrade_cost, multiply_price_tag)
	
	set_correct_notation_on_tag(buy_click_upgrade_info_array[0][2], click_upgrade_button_container.get_children()[0])
	
	set_correct_notation_on_tag(buy_click_progress_button_info_array[0][0], click_progress_button_container.get_children()[0])
	
	set_correct_notation_on_tag(buy_click_progress_bar_info_array[0][0], buy_click_progress_bar_button_container.get_children()[0])
	set_correct_notation_on_tag(buy_click_progress_bar_multi_info_array[0][0], click_progress_bar_multi_button_container.get_children()[0])
	
	set_correct_notation_on_tag(buy_auto_progress_bar_info_array[4][0], auto_progress_bar_button_container.get_children()[0])
	set_correct_notation_on_tag(buy_auto_progress_bar_speed_info_array[0][0], auto_progress_bar_speed_button_container.get_children()[0])
	set_correct_notation_on_tag(buy_auto_progress_bar_multi_info_array[0][0], auto_progress_bar_multi_button_container.get_children()[0])
	
	#for i in progress_bar_container.get_children().size():
		#if(buy_click_progress_bar_info_array[i][1]): 
			#progress_bar_container.get_children()[i].visible = true
			##buy_click_progress_bar_button_tag.text = 'costs ' + str(buy_click_progress_bar_info_array[i][0])
		#else: progress_bar_container.get_children()[i].visible = false

func _process(_delta) -> void:
	if(toggle_unlocked and gain_currency_pass): gain_currency()
	else: pass
