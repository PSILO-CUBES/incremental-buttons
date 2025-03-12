class_name End_Game_Management extends Control

@onready var end_game_container: End_Game_Management = %EndGameContainer
@onready var Game_Object: Data_Management = %GameObject

var end_game_info_arr = [false, 0]

func end_game() -> void:
	if(Game_Object.click < 999999999999999999): return
	Game_Object.click -= 999999999999999999
	
	end_game_info_arr[0] = true
	%EndGameContainer.visible = true
	end_game_container.modulate = Color8(255,255,255,0)
	
	for i in Game_Object.buy_auto_progress_bar_info_array.size():
		Game_Object.buy_auto_progress_bar_info_array[i][1] = false

func _process(delta) -> void:
	if(end_game_info_arr[0]):
		if(end_game_info_arr[1] >= 255): 
			end_game_info_arr[0] = false
			end_game_info_arr[1] = 255
			end_game_container.modulate = Color8(255,255,255,255)
		else: 
			end_game_info_arr[1] += delta * 255
			end_game_container.modulate = Color8(255,255,255,end_game_info_arr[1])
