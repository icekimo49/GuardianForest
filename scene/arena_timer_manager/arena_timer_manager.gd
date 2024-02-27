extends Node2D

@onready var timer = $Timer


func waktu_terbuang():
	return timer.wait_time - timer.time_left
