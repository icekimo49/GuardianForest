extends Resource
class_name PlayerData

@export var hp = 200
@export var exp : int
@export var inv : Inv
@export var wave = 1
@export var time = 0.0
@export var sudah_tutorial = false
@export var pohon = {
	"pohon" = [],
	"pohon_kecil" = []
}

func _ready():
	pass

func _process(delta):
	pass

func change_hp(value : int):
	hp += value

func change_exp(value : int):
	exp += value

func simpan_item(item):
	inv.insert(item)

func change_wave(value: int):
	if wave < 4:
		wave += value

func save_time():
	time = GlobalScript.time
