extends StaticBody2D
var bisa_refill = true

func _on_refill_body_entered(body):
	if body.has_method("player"):
		if bisa_refill:
			GlobalScript.isi_air_gayung +=1
			$cooldown_refill.start()
			bisa_refill = false
			print(GlobalScript.isi_air_gayung)


func _on_cooldown_refill_timeout():
	$cooldown_refill.stop()
	bisa_refill = true
