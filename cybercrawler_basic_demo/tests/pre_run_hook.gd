extends GutHookScript

const Coverage = preload("res://addons/coverage/coverage.gd")

# Coverage requirements - tests will fail if these aren't met
const COVERAGE_TARGET_TOTAL := 75.0    # 75% total coverage required (only when 90% of code has tests)
const COVERAGE_TARGET_FILE := 50.0     # 50% per-file coverage required (only for files with tests)
const MIN_LINES_COVERED := 100         # Minimum lines that must be covered (only in tested files)
const TEST_COVERAGE_THRESHOLD := 90.0  # Only require 75% total coverage when 90% of code has tests

# Exclude paths from coverage analysis
const exclude_paths = [
	"res://addons/*",          # Exclude all addons (GUT, coverage, etc.)
	"res://tests/*",           # Exclude test scripts themselves
	"res://scenes/*",          # Exclude scene files (we only want script coverage)
	"res://tools/*"            # Exclude utility tools
]

func run():
	print("🔥 PRE-RUN HOOK IS RUNNING! 🔥")
	print("=== Initializing Parent Repository Coverage ===")
	
	print("=== Initializing Code Coverage ===")
	
	# Create coverage instance with scene tree and exclusions
	print("DEBUG: Creating Coverage instance...")
	Coverage.new(gut.get_tree(), exclude_paths)
	
	if !Coverage.instance:
		print("❌ CRITICAL: Coverage instance is still null after Coverage.new()!")
		_fail_tests("Coverage system not initialized")
		return
	
	# Instrument all scripts in the scripts directory (when we have one)
	print("DEBUG: Instrumenting scripts in res://scripts/...")
	Coverage.instance.instrument_scripts("res://scripts/")

	# Debug output: print all instrumented scripts
	print("DEBUG: Instrumented scripts:")
	for script_path in Coverage.instance.coverage_collectors.keys():
		print("  - ", script_path)
	print("DEBUG: Total instrumented scripts: %d" % Coverage.instance.coverage_collectors.size())

	# List all .gd scripts in res://scripts/ for comparison
	var all_scripts = []
	_list_all_gd_scripts("res://scripts", all_scripts)
	print("DEBUG: Total .gd scripts in res://scripts/: %d" % all_scripts.size())
	for script in all_scripts:
		if script not in Coverage.instance.coverage_collectors:
			print("  (NOT instrumented): ", script)
	
	print("✓ Coverage instrumentation complete")
	print("✓ Monitoring coverage for: res://scripts/")
	print("✓ Coverage targets: %.1f%% total, %.1f%% per file OR %d lines minimum (whichever is LESS)" % [COVERAGE_TARGET_TOTAL, COVERAGE_TARGET_FILE, MIN_LINES_COVERED])
	print("✓ Excluded paths: ", exclude_paths)
	
	# NOTE: Coverage validation will happen after tests complete
	# The pre-run hook only sets up instrumentation - validation happens post-test
	print("\n✓ Coverage system ready - validation will occur after tests complete\n")

func _get_files_with_tests() -> Array:
	# Get all script files that have corresponding test files
	var files_with_tests = []
	_find_script_files_with_tests("res://scripts", files_with_tests)
	return files_with_tests

func _find_script_files_with_tests(directory: String, files_with_tests: Array):
	# Recursively search for script files and check if they have tests
	var dir = DirAccess.open(directory)
	if !dir:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var full_path = directory + "/" + file_name
		
		if dir.current_is_dir():
			# Recursively search subdirectories
			_find_script_files_with_tests(full_path, files_with_tests)
		elif file_name.ends_with(".gd"):
			# Convert CamelCase to snake_case for test file matching
			var base_name = file_name.get_basename()  # Remove .gd extension
			var snake_case_name = _camel_to_snake_case(base_name)
			var test_file_name = "test_" + snake_case_name + ".gd"

			# Recursively search for test file in all subdirectories under tests/unit and tests/integration
			if _test_file_exists_recursive("res://tests/unit", test_file_name) or _test_file_exists_recursive("res://tests/integration", test_file_name):
				files_with_tests.append(full_path)
		file_name = dir.get_next()

# Helper to recursively search for a test file in a directory and its subdirectories
func _test_file_exists_recursive(directory: String, test_file_name: String) -> bool:
	var dir = DirAccess.open(directory)
	if !dir:
		return false
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var full_path = directory + "/" + file_name
		if dir.current_is_dir():
			if _test_file_exists_recursive(full_path, test_file_name):
				return true
		elif file_name == test_file_name:
			return true
		file_name = dir.get_next()
	return false

func _camel_to_snake_case(camel_case: String) -> String:
	# Convert CamelCase to snake_case
	# GameManager -> game_manager
	# TowerManager -> tower_manager
	var result = ""
	for i in range(camel_case.length()):
		var char = camel_case[i]
		if char.to_upper() == char and i > 0:
			result += "_"
		result += char.to_lower()
	return result

func _fail_tests(reason: String):
	# Log the coverage failure prominently
	print("🚫 COVERAGE VALIDATION FAILED: %s" % reason)
	print("❌ Tests will be FAILED due to insufficient coverage!")
	
	# Push error for logging
	push_error("COVERAGE VALIDATION FAILED: " + reason)
	
	print("🔥 FORCING IMMEDIATE EXIT WITH CODE 1")
	
	# Force immediate exit with code 1 - this should make GitHub Actions fail
	if gut and gut.get_tree():
		gut.get_tree().quit(1)
	else:
		# Fallback: force exit with code 1
		OS.kill(OS.get_process_id()) 

# Helper to recursively list all .gd scripts in a directory
func _list_all_gd_scripts(directory: String, all_scripts: Array):
	var dir = DirAccess.open(directory)
	if !dir:
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var full_path = directory + "/" + file_name
		if dir.current_is_dir():
			_list_all_gd_scripts(full_path, all_scripts)
		elif file_name.ends_with(".gd"):
			all_scripts.append(full_path)
		file_name = dir.get_next() 