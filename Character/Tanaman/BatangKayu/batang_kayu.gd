extends Sprite2D

class_name BatangTexture

@onready var kayu_1 : Texture2D = preload("res://asset/environtment/pohon bekas tebang 1.png")
@onready var kayu_2 : Texture2D= preload("res://asset/environtment/pohon bekas tebang 2.png")

@onready var asset : = {
	"Kayu1" : kayu_1,
	"Kayu2" : kayu_2
}


func _update(delta):
	pass
	
