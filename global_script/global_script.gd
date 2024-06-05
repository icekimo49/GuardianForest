extends Node

var inv : Inv = preload("res://global_script/global_script_temp_inv.tres")
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
var game_berlangsung = false
var enable_analog : bool =false
var time : float = 0.0
var hour
var sudah_tutorial = false
var path_screen_terakhir_sebelum_loading
var boleh_tanam = false
var exp
var scene_sebelum_loading

#pohon
var posisi_pohon = []

#level
var level_berakhir = false


