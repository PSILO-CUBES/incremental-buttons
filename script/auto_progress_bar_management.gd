class_name Auto_Progress_Bar_Management extends Control

@onready var auto_progress_bar_container: Auto_Progress_Bar_Management = $"."

@onready var Data_Manager = %GameObject

func _process(delta: float) -> void:
	for i in auto_progress_bar_container.get_children().size():
		var target = auto_progress_bar_container.get_children().size() - i - 1
		
		if(Data_Manager.buy_auto_progress_bar_info_array[target][1] == false): continue
		
		Data_Manager.buy_auto_progress_bar_info_array[target][2] += delta * Data_Manager.buy_auto_progress_bar_info_array[target][3] * Data_Manager.auto_progress_bar_speed
		auto_progress_bar_container.get_children()[target].value = Data_Manager.buy_auto_progress_bar_info_array[target][2]
		
		if(Data_Manager.buy_auto_progress_bar_info_array[target][2] >= 100):
			Data_Manager.buy_auto_progress_bar_info_array[target][2] = 0
			auto_progress_bar_container.get_children()[target].value = 0
