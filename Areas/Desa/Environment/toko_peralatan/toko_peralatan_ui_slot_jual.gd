extends Panel
@onready var beli_barang = $beli_barang
@onready var tombol = $tombol

func _ready():
	beli_barang.visible = false

func _on_beli_pressed():
	tombol.visible = false
