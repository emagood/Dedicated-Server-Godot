extends Node

class_name Compressor

@export_enum("DEFLATE:1", "GZIP:3") var compression_mode: int = 1

func compress_data(data: PackedByteArray) -> PackedByteArray:
	# Comprimir los datos con un solo argumento
	var compressed_data = data.compress(compression_mode)
	#print("Tamaño comprimido:", compressed_data.size())
	return compressed_data

func decompress_data(compressed_data: PackedByteArray, original_size: int) -> PackedByteArray:
	# Descomprimir los datos
	var decompressed_data = compressed_data.decompress(original_size, compression_mode)
	print("Tamaño descomprimido:", decompressed_data.size())
	return decompressed_data

func get_string_from_bytearray(data: PackedByteArray) -> String:
	return data.get_string_from_utf8()

func get_bytearray_from_string(text: String) -> PackedByteArray:
	return text.to_utf8_buffer()
