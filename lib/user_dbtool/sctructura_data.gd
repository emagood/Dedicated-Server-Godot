'''
 //   8 bit 1 byte 
 //   16 bit 2 byte 
 //   32 bit 4 byte 
 //   64 bit 8 byte 
'''

extends Node

func _ready():
	# Estructura 1
	# - 256 datos de 8 bits
	# - 255 datos de 16 bits
	# - 4 datos de 64 bits
	# - Tamaño total por usuario: 806 bytes
	var estructura_1_tamaño_usuario = 8 + 256 + 255 * 2 + 4 * 8
	print("Estructura 1 - Tamaño total por usuario:", estructura_1_tamaño_usuario, "bytes")
	
	var estructura_1_tamaño_total = estructura_1_tamaño_usuario * 10_000_000
	print("Estructura 1 - Tamaño total para 10 millones de usuarios:", estructura_1_tamaño_total, "bytes")
	print("Estructura 1 - Tamaño total para 10 millones de usuarios:", estructura_1_tamaño_total / (1024 ** 3), "GB")

	# Estructura 2
	# - 512 datos de 8 bits
	# - 128 datos de 16 bits
	# - 8 datos de 64 bits
	# - Tamaño total por usuario: 832 bytes
	var estructura_2_tamaño_usuario = 8 + 512 + 128 * 2 + 8 * 8
	print("Estructura 2 - Tamaño total por usuario:", estructura_2_tamaño_usuario, "bytes")
	
	var estructura_2_tamaño_total = estructura_2_tamaño_usuario * 10_000_000
	print("Estructura 2 - Tamaño total para 10 millones de usuarios:", estructura_2_tamaño_total, "bytes")
	print("Estructura 2 - Tamaño total para 10 millones de usuarios:", estructura_2_tamaño_total / (1024 ** 3), "GB")

	# Estructura 3
	# - 1024 datos de 8 bits
	# - 64 datos de 16 bits
	# - 16 datos de 64 bits
	# - Tamaño total por usuario: 1280 bytes
	var estructura_3_tamaño_usuario = 8 + 1024 + 64 * 2 + 16 * 8
	print("Estructura 3 - Tamaño total por usuario:", estructura_3_tamaño_usuario, "bytes")
	
	var estructura_3_tamaño_total = estructura_3_tamaño_usuario * 10_000_000
	print("Estructura 3 - Tamaño total para 10 millones de usuarios:", estructura_3_tamaño_total, "bytes")
	print("Estructura 3 - Tamaño total para 10 millones de usuarios:", estructura_3_tamaño_total / (1024 ** 3), "GB")
