# CyberCrawler Parent Repository Testing Documentation

## How to Run Tests Locally

### Command Line (Recommended)
```powershell
# Navigate to project directory
cd "C:\Users\rivie\CursorProjects\CyberCrawler\cybercrawler_basic_demo"

# Run all tests (unit + integration)
& "C:\Program Files\Godot\Godot_v4.4.1-stable_win64_console.exe" --headless --script addons/gut/gut_cmdln.gd -gexit
```

### Test Results
✅ **All 6 basic tests passing**  
✅ **Coverage system functional**  
✅ **Pre/Post run hooks working**  

### Current Test Coverage
- **Basic test framework validation**
- **Godot environment checks**
- **Coverage system availability**
- **Project structure validation**
- **Future scripts directory preparation**
- **Parent repository coordination readiness**

### Directory Structure
```
cybercrawler_basic_demo/
├── addons/
│   ├── gut/           # Testing framework
│   └── coverage/      # Code coverage
├── tests/
│   ├── unit/          # Unit tests
│   ├── integration/   # Integration tests (empty for now)
│   ├── pre_run_hook.gd   # Coverage setup
│   └── post_run_hook.gd  # Coverage validation
├── .gutconfig.json    # GUT configuration
└── project.godot     # Godot project file
```

### Notes
- This setup matches the tower defense repository exactly
- Ready for coordination system scripts when they're added
- GitHub Actions workflow is configured and ready 