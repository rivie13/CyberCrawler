class_name TestCalculator
extends RefCounted

# Simple calculator class for testing code coverage
# This script demonstrates different code paths for coverage testing

func add(a: int, b: int) -> int:
	return a + b

func subtract(a: int, b: int) -> int:
	return a - b

func multiply(a: int, b: int) -> int:
	if a == 0 or b == 0:
		return 0
	return a * b

func divide(a: int, b: int) -> float:
	if b == 0:
		push_error("Division by zero!")
		return 0.0
	return float(a) / float(b)

func is_even(number: int) -> bool:
	if number % 2 == 0:
		return true
	else:
		return false

func get_absolute_value(number: int) -> int:
	if number < 0:
		return -number
	return number

func calculate_factorial(n: int) -> int:
	if n < 0:
		push_error("Factorial of negative number is undefined!")
		return -1
	elif n == 0 or n == 1:
		return 1
	else:
		var result = 1
		for i in range(2, n + 1):
			result *= i
		return result

func find_maximum(numbers: Array) -> int:
	if numbers.is_empty():
		push_error("Cannot find maximum of empty array!")
		return 0
	
	var max_value = numbers[0]
	for number in numbers:
		if number > max_value:
			max_value = number
	return max_value

func is_prime(number: int) -> bool:
	if number <= 1:
		return false
	elif number <= 3:
		return true
	elif number % 2 == 0 or number % 3 == 0:
		return false
	
	var i = 5
	while i * i <= number:
		if number % i == 0 or number % (i + 2) == 0:
			return false
		i += 6
	
	return true 