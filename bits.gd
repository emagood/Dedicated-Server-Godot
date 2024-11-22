extends Control
#
#func _ready():
	## Pruebas con diferentes longitudes de bits
	#var bytes_8 = PackedByteArray([34])  # 8 bits
	#var bytes_16 = PackedByteArray([0x12, 0x34])  # 16 bits (2 bytes: 0x1234)
	#var bytes_128 = PackedByteArray([0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88])  # 128 bits (16 bytes)
	#var bytes_large = PackedByteArray()
	#for i in range(4096):
		#bytes_large.append(randi() % 256)  # Generar 4096 bytes aleatorios (mayor a 4k bytes)
	#
	## Obtener las posiciones de los bits
	#var bit_positions_8 = get_bit_positions(bytes_8, 8)
	#var bit_positions_16 = get_bit_positions(bytes_16, 16)
	#var bit_positions_128 = get_bit_positions(bytes_128, 128)
	#var bit_positions_large = get_bit_positions(bytes_large, 4096 * 8)  # 4096 bytes * 8 bits por byte
#
	## Imprimir las posiciones de los bits
	#print("8 bits:")
	#print_bits(bit_positions_8)
	#
	#print("16 bits:")
	#print_bits(bit_positions_16)
	#
	#print("128 bits:")
	#print_bits(bit_positions_128)
	#
	#print("4096 bytes:")
	#print_bits(bit_positions_large)
#
## Función para obtener posiciones de bits para longitudes variables
#func get_bit_positions(packet: PackedByteArray, bit_length: int) -> Array:
	#var bit_positions = []
	#
	#for byte in packet:
		#var byte_bits = []
		#for bit in range(8):
			#var bit_value = (byte >> bit) & 1
			#byte_bits.append(bit_value)
		#bit_positions.append(byte_bits)
	#
	#return bit_positions
#
## Función para imprimir las posiciones de bits
#func print_bits(bit_positions: Array) -> void:
	#for byte_bits in bit_positions:
		#var bit_string = ""
		#for bit in byte_bits:
			#bit_string += str(bit)
		#print(bit_string)
#
## Función para asignar parámetros a bits de forma aleatoria
#func assign_random_bits(length: int) -> PackedByteArray:
	#var packet = PackedByteArray()
	#for i in range(length):
		#packet.append(randi() % 256)  # Generar bytes aleatorios
	#return packet
