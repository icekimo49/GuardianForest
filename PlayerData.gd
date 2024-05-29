extends Resource
class_name PlayerData

@export var hp = 200
@export var exp : int
@export var inv: Inv
@export var wave = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func change_hp(value : int):
	hp += value

func change_exp(value : int):
	exp += value

func simpan_item(item):
	inv.insert(item)

func change_wave(value: int):
	wave += 1
	print(wave)
