extends Node2D

var arr_gambar = [
	[preload("res://buff/Heading (16).png"), "+5% Speed"],
	[preload("res://buff/Heading (18).png"), "+5% Area Kentongan"],
	[preload("res://buff/Heading (19).png"), "+7% Hitpoint"]
]

var index1
var index2

func _ready():
	display()

func display():
	index1 = randi_range(0, arr_gambar.size()-1)
	index2 = randi_range(0, arr_gambar.size()-1)
	while index2 == index1:
		index2  = randi_range(0, arr_gambar.size()-1)
	$"1".texture = arr_gambar[index1][0]
	$"1".scale = Vector2(0.392, 0.392)
	$"1/1".text = arr_gambar[index1][1]
	$"2".texture = arr_gambar[index2][0]
	$"2".scale = Vector2(0.392, 0.392)
	$"2/2".text = arr_gambar[index2][1]

func _on_button_1_pressed():
	queue_free()

func _on_button_2_pressed():
	queue_free()
