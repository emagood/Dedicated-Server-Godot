extends Node
var array_data = []
var dict_data = {}
@export var total = 100
@export var num_tests = 10000
func _ready():
	# Crear un array y un diccionario con 10,000 datos aleatorios de 64 bits
	pass


func _on_random_buscar_10k_pressed() -> void:
	if total <= 0 :
		prints("error no ay datos ")
		return
	var timer_local = Time.get_ticks_usec()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	prints("empieza el conteo ")
	#num_tests = 
	for i in range(total):
		var random_index = rng.randi_range(0, total)
				# Medir el tiempo de búsqueda en el diccionario
		var dict_start_time = Time.get_ticks_usec()
		var dict_value = dict_data[str(random_index)]
		var dict_end_time = Time.get_ticks_usec()

	prints(" el diccionario demoro  (" ,Time.get_ticks_usec() - timer_local,") en usec")
	prints(dict_data["1"])
	pass # Replace with function body.


func _on_button_pressed() -> void:
	if total > 5000000 :
		prints("ya existen 5 millones de tablas en el diccionario ")
		return
	# Semilla para la generación aleatoria
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	prints("empieza la tabla")

	for i in range(total): # 10 millones wtfk es buenisimo
		#total += 1
		var random_value = rng.randf_range(-1.0e9, 1.0e9)  # Generar un número aleatorio de 64 bits
		array_data.append(random_value) # array 
		dict_data[str(i)] = random_value  # Usar el índice como clave en el diccionario

	# Pruebas de búsqueda aleatoria

	var array_search_times = []
	var dict_search_times = []


	prints("empieza el conteo ")





	'''
////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
'''
	var timer_local = Time.get_ticks_usec()
	for i in range(num_tests):
		var random_index = rng.randi_range(0, total-1)
		
		# Medir el tiempo de búsqueda en el array
		var array_start_time = Time.get_ticks_usec()
		var array_value = array_data[random_index]
		var array_end_time = Time.get_ticks_usec()
		array_search_times.append(array_end_time - array_start_time)
	prints(" el array demoro  (" ,Time.get_ticks_usec() - timer_local,") en usec")

		
	for i in range(num_tests):
		var random_index = rng.randi_range(0, total-1)
				# Medir el tiempo de búsqueda en el diccionario
		var dict_start_time = Time.get_ticks_usec()
		var dict_value = dict_data[str(random_index)]
		var dict_end_time = Time.get_ticks_usec()

	prints(" el diccionario demoro  (" ,Time.get_ticks_usec() - timer_local,") en usec")
	prints("total de datos :(", total , ") total de iteraciones :(", num_tests , ")")
	prints(dict_data["1"])
	prints(array_data[1])
	# Calcular los tiempos promedio de búsqueda
	#var avg_array_search_time = 0
	#for time in array_search_times:
		#avg_array_search_time += time
	#avg_array_search_time /= num_tests
#
	#var avg_dict_search_time = 0
	#for time in dict_search_times:
		#avg_dict_search_time += time
	#avg_dict_search_time /= num_tests
	#prints("promedio de espera de busqueda array :" ,avg_array_search_time , " promedio de diccionario : ", avg_dict_search_time)
	#pass # Replace with function body.


func _on_random_buscar_100k_pressed() -> void:
	if total <= 0 :
		prints("error no ay datos ")
		return
	var timer_local = Time.get_ticks_usec()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	prints("empieza el conteo ")
	var num_tests = 10000
	for i in range(num_tests):
		var random_index = rng.randi_range(0, total)
				# Medir el tiempo de búsqueda en el diccionario
		var dict_start_time = Time.get_ticks_usec()
		var dict_value = dict_data[str(random_index)]
		var dict_end_time = Time.get_ticks_usec()

	prints(" el diccionario demoro  (" ,Time.get_ticks_usec() - timer_local,") en usec")
	prints(dict_data["1"])
	pass # Replace with function body.

	pass # Replace with function body.


func _on_millon_pressed() -> void:
	if total > 1000999 :
		prints("ya existen 1 millones de tablas en el diccionario ")
		return
	# Semilla para la generación aleatoria
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	prints("empieza la tabla")

	for i in range(1000000): # 10 millones wtfk es buenisimo
		total += 1
		var random_value = rng.randf_range(-1.0e9, 1.0e9)  # Generar un número aleatorio de 64 bits
		#array_data.append(random_value)
		dict_data[str(i)] = random_value  # Usar el índice como clave en el diccionario

	# Pruebas de búsqueda aleatoria
	var num_tests = 10000
	var array_search_times = []
	var dict_search_times = []

	var timer_local = Time.get_ticks_usec()
	prints("empieza el conteo ")
	
	pass # Replace with function body.
