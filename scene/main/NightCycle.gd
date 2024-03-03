extends CanvasModulate


const malam = Color("#265979")
const siang = Color("#ffffff")
const selangWaktu = 0.00001

var time = 0

func _process(delta):
	time += delta * 0.0064
	color = malam.lerp(siang,abs(sin(time)))
