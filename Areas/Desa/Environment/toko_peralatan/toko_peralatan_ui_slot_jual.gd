extends Panel
@onready var beli_barang = $beli_barang
@onready var tombol = $tombol
@onready var array_beli : Array = $beli_barang/VBoxContainer.get_children()
var slot_jual = preload("res://Areas/Desa/Environment/toko_peralatan/slot_jual.tscn")
var array_beli_isi = [
	[preload("res://Item/Tools/granat_pemadam_api/Granat Pemadam Api.png"), "Granat Pemadam Api", "20", Vector2(0.4, 0.4), "granat_pemadam"],
	[preload("res://Item/Material/biji/biji.png"), "Biji Pohon", "10", Vector2(0.4, 0.4), "biji"],
	[preload("res://Item/Tools/kentongan/kentongan.png"), "Kentongan", "250", Vector2(0.15, 0.15), "kentongan"],
	[preload("res://Item/Tools/ember1.png"), "Ember", "150", Vector2(0.25, 0.25), "ember"]
]

func _ready():
	$beli_barang.hide()
	$jual_barang.hide()
	
func _process(delta):
	$Node2D/Label.text = str(GlobalScript.uang)

func _on_beli_pressed():
	tombol.hide()
	$beli_barang.show()
	display_beli(array_beli)

func _on_jual_pressed():
	tombol.hide()
	await display_jual()
	$jual_barang.show()

func display_beli(arr):
	var i = 0
	while i < array_beli_isi.size():
		arr[i].get_node("item_picture").texture = array_beli_isi[i][0]
		arr[i].get_node("item_picture").scale = array_beli_isi[i][3]
		arr[i].get_node("item_name").text = array_beli_isi[i][1]
		arr[i].get_node("item_price").text = "$" + array_beli_isi[i][2]
		arr[i].item_name = array_beli_isi[i][4]
		arr[i].price = int(array_beli_isi[i][2])
		i+=1

func display_jual():
	var i = 0
	var arr = GlobalScript.inv.slots
	while i < arr.size()-1:
		if arr[i].item != null:
			var slotjual = slot_jual.instantiate()
			slotjual.name = "slot_jual_" + str(i)
			slotjual.inv_slot = i
			slotjual.get_node("item_picture").texture = arr[i].item.texture
			slotjual.get_node("item_picture").scale = ukuran(arr[i].item.name)
			slotjual.get_node("item_name").text = arr[i].item.name
			slotjual.get_node("item_price").text = "$" + str(harga(arr[i].item.name))
			slotjual.get_node("sisa").text = "Sisa : " + str(arr[i].amount)
			slotjual.price = harga(arr[i].item.name)
			slotjual.amount = arr[i].amount
			$jual_barang/ScrollContainer/VBoxContainer.add_child(slotjual)
			i+=1
		else:
			i+=1

func harga(nama):
	var harga
	if nama == "biji":
		harga = 5
	elif nama == "batu":
		harga = 5
	elif nama == "kentongan":
		harga = 100
	elif nama == "granat_pemadam":
		harga = 10
	else:
		harga = 10
	return harga

func ukuran(nama):
	var ukuran
	if nama == "kentongan":
		ukuran = Vector2(0.15, 0.15)
	elif nama == "biji":
		ukuran = Vector2(0.4, 0.4)
	elif nama == "granat_pemadam":
		ukuran = Vector2(0.4, 0.4)
	elif nama == "ember":
		ukuran = Vector2(0.25, 0.25)
	elif nama == "Batu":
		ukuran = Vector2(0.02, 0.02)
	else:
		ukuran = Vector2(0.5, 0.5)
	print(nama, ukuran)
	return ukuran
	
func _on_kembali_pressed():
	$Player.save()
	$beli_barang.hide()
	$jual_barang.hide()
	tombol.show()
