extends Node

var tombol_serang : bool = false
var player_current_attack = false
var pencet = false
var player_serang_atas = false
var player_serang_kanan = false
var player_serang_kiri = false
var player_serang_bawah = false
var isi_air_gayung : int
var inv_is_open = false
var drop_item_loc
var drop_item = false
var malam : bool = true
var select1 = null
var select2 = null
var item_in_use : String
var tingkat_wave = 1
var mulai_game : bool
var game_berlangsung : bool
var enable_analog : bool =false

#pohon
var posisi_pohon = []

#level
var level_berakhir = false


