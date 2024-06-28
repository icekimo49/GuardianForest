extends Panel

var boleh_beli = true
@onready var player = $"../../".get_node("Ysort").get_node("Player")
var arr_makanan =[
	[preload("res://Item/makanan/Apel.png"), "Apel", "10", 20, Vector2(1, 1)],
	[preload("res://Item/makanan/Roti.png"), "Roti", "20", 40, Vector2(0.2, 0.2)]
]
var slot = preload("res://Areas/Desa/Environment/Tempat_makan/rumah_makan_ui_slot.tscn")

func _ready():
	display()

func display():
	var i = 0
	while i < arr_makanan.size():
		var slot_ = slot.instantiate()
		slot_.get_node("item_picture").texture = arr_makanan[i][0]
		slot_.get_node("item_name").text = arr_makanan[i][1]
		slot_.get_node("item_benefit").text = "HP +" + arr_makanan[i][2]
		slot_.get_node("item_price").text = "$" + str(arr_makanan[i][3])
		slot_.get_node("item_picture").scale = arr_makanan[i][4]
		$Control/ScrollContainer/VBoxContainer.add_child(slot_)
		i+=1

func sudah_beli():
	var text_arr = ["Terima Kasih sudah membeli produk kami!", "Uangnya pas mas", "Kembaliannya permen aja ya!"]
	var face_arr = [preload("res://Character/Mbok_yem/PenjagaToko Makanan_ngomong.png"), preload("res://Character/Mbok_yem/PenjagaTokoMakanan_Senyum.png")]
	var index = randi_range(0, text_arr.size()-1)
	$mbok_yem.texture = face_arr[0]
	$dialog.text = text_arr[index]
	await get_tree().create_timer(1.5).timeout
	$mbok_yem.texture = face_arr[1]
	$dialog.text = " "
	boleh_beli = true


func _on_button_pressed():
	self.hide()
