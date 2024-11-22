extends Control

@export_enum("YES_ARRAY:0", "NOT_NADA:1") var PRUEBA: int = 0
@export_enum("DEFLATE:1", "GZIP:3") var MODE_COMPRESSION: int = 1

var cadena = "ddelas manzanas nace frujhfjfsnhooooooooooodmksmkmkmkmkmkmkkkmta verde y rojaeu"
var string_length
var bytes: PackedByteArray

func _ready() -> void:
	# Crear una instancia de la clase Compressor
	var compressor = Compressor.new()

	# Convertir la cadena a PackedByteArray
	bytes = compressor.get_bytearray_from_string(cadena)
	string_length = bytes.size()

	print("Datos originales:", bytes)
	print("Tamaño de datos originales:", bytes.size())
	
	# Generar números aleatorios usando un hash de "godot" como semilla
	var hash_value = hash("ddelas")
	var rng = RandomNumberGenerator.new()
	rng.seed = hash_value
	
	var num_copias = 64
	var mejor_comprimido = bytes
	var mejor_tamaño = bytes.size()
	
	for i in range(num_copias):
		var random_data = PackedByteArray()
		for j in range(string_length):
			random_data.append(rng.randi() % 256)
		
		# Realizar operación XOR entre la cadena original y los datos aleatorios
		var xor_result = bitwise_operation(bytes, random_data, "xor")
		print("XOR resultado:", xor_result)
		
		# Comprimir el resultado XOR
		var compressed_data = compressor.compress_data(xor_result)
		print("Tamaño de datos comprimidos:", compressed_data.size())
		print("Datos comprimidos:", compressed_data)
		
		# Comparar tamaños y guardar el menor
		if compressed_data.size() < mejor_tamaño:
			mejor_comprimido = compressed_data
			mejor_tamaño = compressed_data.size()

	print("Mejor tamaño comprimido:", mejor_tamaño)
	print("Mejor dato comprimido:", mejor_comprimido)

# Función para realizar operaciones lógicas bit a bit (en este caso, XOR)
func bitwise_operation(num1: PackedByteArray, num2: PackedByteArray, operation: String) -> PackedByteArray:
	var result = PackedByteArray()
	for i in range(num1.size()):
		var byte1 = num1[i]
		var byte2 = num2[i]
		var res = 0
		match operation:
			"xor":
				res = byte1 ^ byte2
		result.append(res)
	return result

func _process(delta: float) -> void:
	pass
