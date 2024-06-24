extends Node2D

var i

func mulai_():
	i = 3
	#dibikin timer biar tombolnya tunggu waktu dulu buat bisa dipencet
	$Label.text = str(i)

func _on_timer_timeout():
	i-=1
	$Label.text = str("i")

func _process(delta):
	if i == 0:
		$Timer.stop()
		$HSplitContainer/keluar.disabled = false
		$HSplitContainer/respawn.disabled = false

func _on_keluar_pressed():
	$"../../".balik_ke_desa()

func _on_respawn_pressed():
	$"../../".respawn_di_hutan()
