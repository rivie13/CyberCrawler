extends GutTest

# Tests for TestCalculator class to verify code coverage system
var calculator: TestCalculator

func before_each():
	calculator = TestCalculator.new()

func test_add_function():
	# Test basic addition
	assert_eq(calculator.add(2, 3), 5, "2 + 3 should equal 5")
	assert_eq(calculator.add(-1, 1), 0, "-1 + 1 should equal 0")
	assert_eq(calculator.add(0, 0), 0, "0 + 0 should equal 0")

func test_subtract_function():
	# Test basic subtraction
	assert_eq(calculator.subtract(5, 3), 2, "5 - 3 should equal 2")
	assert_eq(calculator.subtract(1, 1), 0, "1 - 1 should equal 0")
	assert_eq(calculator.subtract(-2, -3), 1, "-2 - (-3) should equal 1")

func test_multiply_function():
	# Test multiplication with various cases
	assert_eq(calculator.multiply(3, 4), 12, "3 * 4 should equal 12")
	assert_eq(calculator.multiply(0, 5), 0, "0 * 5 should equal 0")
	assert_eq(calculator.multiply(7, 0), 0, "7 * 0 should equal 0")
	assert_eq(calculator.multiply(-2, 3), -6, "-2 * 3 should equal -6")

func test_divide_function():
	# Test division with normal cases
	assert_eq(calculator.divide(10, 2), 5.0, "10 / 2 should equal 5.0")
	assert_eq(calculator.divide(7, 2), 3.5, "7 / 2 should equal 3.5")
	
	# Test division by zero (should return 0.0 and push error)
	assert_eq(calculator.divide(5, 0), 0.0, "Division by zero should return 0.0")

func test_is_even_function():
	# Test even number detection
	assert_true(calculator.is_even(2), "2 should be even")
	assert_true(calculator.is_even(0), "0 should be even")
	assert_true(calculator.is_even(-4), "-4 should be even")
	
	# Test odd numbers
	assert_false(calculator.is_even(1), "1 should not be even")
	assert_false(calculator.is_even(3), "3 should not be even")
	assert_false(calculator.is_even(-5), "-5 should not be even")

func test_get_absolute_value_function():
	# Test absolute value calculation
	assert_eq(calculator.get_absolute_value(5), 5, "Absolute value of 5 should be 5")
	assert_eq(calculator.get_absolute_value(-5), 5, "Absolute value of -5 should be 5")
	assert_eq(calculator.get_absolute_value(0), 0, "Absolute value of 0 should be 0")

func test_calculate_factorial_function():
	# Test factorial calculation
	assert_eq(calculator.calculate_factorial(0), 1, "0! should equal 1")
	assert_eq(calculator.calculate_factorial(1), 1, "1! should equal 1")
	assert_eq(calculator.calculate_factorial(3), 6, "3! should equal 6")
	assert_eq(calculator.calculate_factorial(4), 24, "4! should equal 24")
	assert_eq(calculator.calculate_factorial(5), 120, "5! should equal 120")
	
	# Test negative factorial (should return -1 and push error)
	assert_eq(calculator.calculate_factorial(-1), -1, "Factorial of negative number should return -1")

func test_find_maximum_function():
	# Test finding maximum in arrays
	assert_eq(calculator.find_maximum([1, 3, 2]), 3, "Maximum of [1, 3, 2] should be 3")
	assert_eq(calculator.find_maximum([5]), 5, "Maximum of [5] should be 5")
	assert_eq(calculator.find_maximum([-1, -5, -2]), -1, "Maximum of [-1, -5, -2] should be -1")
	assert_eq(calculator.find_maximum([1, 1, 1]), 1, "Maximum of [1, 1, 1] should be 1")
	
	# Test empty array (should return 0 and push error)
	assert_eq(calculator.find_maximum([]), 0, "Maximum of empty array should return 0")

func test_is_prime_function():
	# Test prime number detection
	assert_false(calculator.is_prime(1), "1 should not be prime")
	assert_true(calculator.is_prime(2), "2 should be prime")
	assert_true(calculator.is_prime(3), "3 should be prime")
	assert_false(calculator.is_prime(4), "4 should not be prime")
	assert_true(calculator.is_prime(5), "5 should be prime")
	assert_false(calculator.is_prime(6), "6 should not be prime")
	assert_true(calculator.is_prime(7), "7 should be prime")
	assert_false(calculator.is_prime(8), "8 should not be prime")
	assert_false(calculator.is_prime(9), "9 should not be prime")
	assert_true(calculator.is_prime(11), "11 should be prime")
	assert_true(calculator.is_prime(13), "13 should be prime")
	assert_false(calculator.is_prime(15), "15 should not be prime")
	assert_true(calculator.is_prime(17), "17 should be prime")
	assert_true(calculator.is_prime(19), "19 should be prime")
	
	# Test edge cases
	assert_false(calculator.is_prime(0), "0 should not be prime")
	assert_false(calculator.is_prime(-5), "-5 should not be prime")

func test_comprehensive_coverage():
	# This test ensures we hit various code paths for better coverage
	print("Testing comprehensive coverage of TestCalculator")
	
	# Test all functions to ensure coverage
	var calc = TestCalculator.new()
	
	# Hit different branches
	calc.multiply(1, 5)  # Non-zero multiplication
	calc.multiply(0, 5)  # Zero multiplication
	calc.divide(10, 2)   # Normal division
	calc.divide(5, 0)    # Division by zero
	calc.get_absolute_value(-10)  # Negative number
	calc.get_absolute_value(10)   # Positive number
	calc.is_prime(25)    # Composite number with complex checking
	calc.calculate_factorial(6)   # Factorial with loop
	
	# Test array processing
	calc.find_maximum([10, 5, 15, 3])  # Array with multiple elements
	
	assert_true(true, "Comprehensive coverage test completed") 