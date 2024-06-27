extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]
@export var temp_inv: InvSlot

func insert(item: InvItem):
	if slots[8].item == null or item == slots[8].item and item.stack == true:
		if slots[8].item == null:
			slots[8].item = item
			slots[8].amount = 1
		else:
			slots[8].amount +=1
	elif slots[9].item == null or item == slots[9].item and item.stack == true:
		if slots[9].item == null:
			slots[9].item = item
			slots[9].amount = 1
		else:
			slots[9].amount +=1
	elif slots[10].item == null or item == slots[10].item and item.stack == true:
		if slots[10].item == null:
			slots[10].item = item
			slots[10].amount = 1
		else:
			slots[10].amount +=1
	else:
		var itemslots = slots.filter(func(slot): return slot.item == item)
		if !itemslots.is_empty():
			if itemslots[0].item.stack == true:
				itemslots[0].amount +=1
			else:
				var emptyslots = slots.filter(func(slot): return slot.item == null)
				if !emptyslots.is_empty():
					emptyslots[0].item = item
					emptyslots[0].amount = 1
		else:
			var emptyslots = slots.filter(func(slot): return slot.item == null)
			if !emptyslots.is_empty():
				emptyslots[0].item = item
				emptyslots[0].amount = 1
	update.emit()

func decrease(slot):
	slots[slot].amount -= 1
	if slots[slot].amount == 0:
		slots[slot].item = null
	update.emit()

func swap_item_slot(select1, select2):
	if select1 != null && select2 != null:
		temp_inv = slots[select1]
		slots[select1] = slots[select2]
		slots[select2] = temp_inv
		update.emit()
