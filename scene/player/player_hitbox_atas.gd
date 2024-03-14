extends CollisionShape2D

func _ready():
	# Menonaktifkan CollisionShape2D saat permainan dimulai
	disabled = true

# Fungsi untuk mengaktifkan atau menonaktifkan CollisionShape2D
func toggle_collision(aktif: bool):
	disabled = !aktif
	print("atas")
