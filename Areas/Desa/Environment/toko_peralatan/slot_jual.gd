extends Panel

var inv_slot
var price
var amount

func _on_jual_pressed():
	GlobalScript.inv.decrease(inv_slot)
	if GlobalScript.inv.slots[inv_slot].amount == 0:
		queue_free()
	else:
		$sisa.text = "Sisa : " + str(GlobalScript.inv.slots[inv_slot].amount)


func _on_jual_semua_pressed():
	GlobalScript.uang += (amount * price)
	GlobalScript.inv.clear(inv_slot)
	self.queue_free()
