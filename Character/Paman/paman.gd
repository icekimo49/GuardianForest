extends CharacterBody2D

func _ready():
	Dialogic.signal_event.connect(dialogselesai)

func dialog_paman_inun_desa_1():
	matiinvisible()
	Dialogic.start("desa_1")

func dialog_paman_inun_desa_2():
	Dialogic.start("desa_2")

func dialog_paman_inun_desa_3():
	Dialogic.start("desa_3")

func dialog_paman_inun_desa_4():
	Dialogic.start("desa_4")

func dialog_paman_inun_desa_5():
	Dialogic.start("desa_5")

func dialog_paman_inun_hutan_1():
	matiinvisible()
	Dialogic.start("hutan1")

func dialog_paman_inun_hutan_2():
	matiinvisible()
	Dialogic.start("hutan2")

func dialog_paman_inun_hutan_3():
	matiinvisible()
	Dialogic.start("hutan3")

func dialogselesai(arg:String):
	if arg == "dialog_desa_1_selesai":
		get_parent().get_parent().lanjut = true
		print("a")
	elif arg == "dialog_desa_2_selesai":
		get_parent().get_parent().ubah_arah = true
		get_parent().get_parent().dialog_paman_inun = true
	elif arg == "dialog_desa_3_selesai":
		get_parent().get_parent().kamera_ke_penjual_makan()
	elif arg == "dialog_desa_4_selesai":
		get_parent().get_parent().kamera_ke_toko_peralatan()
	elif arg == "dialog_desa_5_selesai":
		GlobalScript.sudah_tutorial = true
		get_parent().get_parent().get_node("Player").save()
		queue_free()
	elif arg == "dialog_hutan_1_selesai":
		get_parent().get_parent().ubah_kamera()
	elif arg == "dialog_hutan_2_selesai":
		nyalainvinsible()
	elif arg == "dialog_hutan_3_selesai":
		nyalainvinsible()
		get_parent().get_parent().balik_desa()

func gerakan_tutorial(tujuan):
	velocity = global_position.direction_to(tujuan) * 150
	move_and_slide()

func matiinvisible():
	get_parent().get_parent().get_node("UI").get_node("joystick").visible = false
	get_parent().get_parent().get_node("UI").get_node("joystick").no_input = true
	get_parent().get_parent().get_node("inventory").get_node("MiniInventory").visible = false
	get_parent().get_parent().get_node("inv").get_node("Inv_UI").visible = false
	get_parent().get_parent().get_node("tombol_serang").get_node("tombolSerang").visible = false

func nyalainvinsible():
	get_parent().get_parent().get_node("UI").get_node("joystick").visible = true
	get_parent().get_parent().get_node("UI").get_node("joystick").no_input = false
	get_parent().get_parent().get_node("inventory").get_node("MiniInventory").visible = true
	get_parent().get_parent().get_node("inv").get_node("Inv_UI").visible = true
	get_parent().get_parent().get_node("tombol_serang").get_node("tombolSerang").visible = true
