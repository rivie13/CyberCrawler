# CyberCrawler Parent Repository - Copilot Instructions

## 🎮 Project Overview

CyberCrawler is a hybrid stealth-action tower defense game built in Godot 4.x. This parent repository is currently in **Phase 1: Core Coordination Framework** and serves as the coordination layer between specialized submodules.

### Core Game Concept
- **Stealth Phase**: 2.5D stealth gameplay where players navigate corporate environments
- **Tower Defense Phase**: Strategic TD gameplay when accessing terminals to hack networks
- **Concurrent Execution**: Both systems run simultaneously with bidirectional communication
- **Asymmetrical Warfare**: Player as underdog fighting corporate technological behemoth

### Current Repository Architecture
This is a **coordination repository** that orchestrates communication between specialized submodules:

```
CyberCrawler/ (Parent Repository)
├── cybercrawler_basic_demo/          # MAIN GAME PROJECT (coordination layer)
│   ├── project.godot                 # Main project config
│   ├── main.tscn                    # Entry point scene
│   ├── scripts/
│   │   ├── GameCoordinator.gd       # Orchestrates submodules
│   │   ├── DI/Injector.gd           # Dependency injection
│   │   └── interfaces/              # Communication contracts
│   ├── external/                    # External submodule references
│   │   ├── tower_defense.tscn       # Reference to TD submodule
│   │   └── stealth_action.tscn      # Reference to Stealth submodule
│   ├── tower-defense/               # Git submodule INSIDE main project
│   │   └── cybercrawler_basictowerdefense/
│   └── stealth-action/              # Git submodule INSIDE main project
│       └── cybercrawler_basicstealthaction/
├── documentation/                    # Project documentation
└── documentation_highlevel/         # High-level architecture docs
```

## 🏗️ Technical Architecture

### **Core Technologies**
- **Engine**: Godot 4.x
- **Language**: GDScript
- **Testing**: GUT (Godot Unit Testing) framework
- **Version Control**: Git with submodule orchestration
- **Architecture**: Interface-driven dependency injection

### **Development Workflow**
- **Git Flow**: `feature/bugfix/issue` → `dev` → `main`
- **Submodule Management**: Each submodule follows independent development cycles
- **Integration Testing**: Happens at the parent repository level
- **Cross-System Communication**: Through well-defined interfaces

### **Submodule Structure**
- **tower-defense/**: Complete TD game system with comprehensive testing
- **stealth-action/**: 2.5D stealth gameplay system (in development)
- **Both submodules**: Self-contained Godot projects with their own `project.godot`

## 📡 Communication Architecture

### **Signal-Based Communication Pattern**
Following Godot's dependency injection principles, submodules communicate through interfaces and signals:

```gdscript
# Communication Flow Example
Terminal (in Stealth) → StealthMain → GameCoordinator → TowerDefenseInterface → TD System
     ↑                                                                              ↓
     └── Alert Response ← SessionManager ← GameCoordinator ← TD Alert Signal ←─────┘
```

### **Interface Contracts**

#### **StealthActionInterface.gd**
```gdscript
class_name StealthActionInterface
extends Node

# Signals TO parent coordinator
signal terminal_activated(terminal_type: String, context: Dictionary)
signal stealth_alert_triggered(alert_level: int, context: Dictionary)
signal mission_objective_completed(objective_id: String, result: Dictionary)
signal player_state_changed(state: Dictionary)

# Methods FROM parent coordinator
func initialize_stealth_session(mission_context: MissionContext) -> void
func receive_td_alert(alert_data: Dictionary) -> void
func update_mission_progress(progress_data: Dictionary) -> void
func set_background_mode(enabled: bool) -> void
```

#### **TowerDefenseInterface.gd**
```gdscript
class_name TowerDefenseInterface  
extends Node

# Signals TO parent coordinator
signal td_session_activated(session_data: Dictionary)
signal rival_hacker_triggered(trigger_context: Dictionary)
signal td_mission_completed(results: Dictionary)
signal td_alert_generated(alert_data: Dictionary)

# Methods FROM parent coordinator  
func initialize_td_session(mission_context: MissionContext) -> void
func receive_stealth_alert(alert_data: Dictionary) -> void
func set_background_mode(enabled: bool) -> void
func configure_mission_parameters(config: Dictionary) -> void
```

## 🚨 Alert System Coordination

### **Bidirectional Alert Flow**
The alert system coordinates events between both systems in real-time:

```
Stealth Alert (Player spotted by guard)
    ↓
StealthActionInterface.stealth_alert_triggered
    ↓
GameCoordinator.handle_stealth_alert()
    ↓
TowerDefenseInterface.receive_stealth_alert()
    ↓
TD System: Activate rival hacker, increase difficulty
    ↓
TD System: rival_hacker_triggered signal
    ↓
GameCoordinator.handle_td_alert()
    ↓
StealthActionInterface.receive_td_alert()
    ↓
Stealth System: Alert guards, increase patrols
```

## 🎯 Terminal Integration Architecture

### **Physical vs. Logical Separation**
**Terminals are PHYSICAL objects in the stealth world** but provide **LOGICAL interfaces to TD systems**.

```
Physical Terminal (Stealth World)
├── Terminal Scene (.tscn in stealth-action/)
│   ├── Sprite2D (Visual representation)
│   ├── Area2D (Player interaction detection)
│   ├── CollisionShape2D (Interaction bounds)
│   └── AnimationPlayer (Terminal animations)
└── Terminal Script (.gd in stealth-action/)
    ├── Player interaction handling
    ├── Security level validation
    ├── Signal emission to parent coordinator
    └── UI overlay management

Logical Interface (Parent Coordination)
├── GameCoordinator receives terminal signals
├── SessionManager updates mission context
├── TowerDefenseInterface configures TD parameters
└── TD System receives configuration and activates
```

## 📊 Session Management & Data Flow

### **Mission Context Data Structure**
```gdscript
class_name MissionContext
extends Resource

# Mission Parameters (from stealth system)
@export var mission_id: String
@export var facility_type: String  
@export var base_security_level: int
@export var player_equipment: Array[String]
@export var mission_time_limit: float

# TD Configuration (derived from mission)
@export var td_starting_currency: int
@export var td_available_towers: Array[String]
@export var td_wave_difficulty_modifier: float
@export var td_rival_activation_threshold: float
@export var td_grid_constraints: Dictionary

# Dynamic State (updated during gameplay)
@export var current_alert_level: int
@export var terminals_accessed: Array[String]
@export var td_sessions_completed: int
@export var player_health_carryover: int
@export var stealth_mission_progress: Dictionary
@export var td_mission_progress: Dictionary
```

## 🧪 Testing Strategy

### **Unit Testing Scope**
- **GameCoordinator**: Signal routing, submodule initialization
- **SessionManager**: State persistence, data serialization
- **Interface classes**: Signal emission, data validation
- **Mission context**: Data structure integrity

### **Integration Testing Scope**
- **Submodule loading**: Both systems initialize correctly
- **Cross-system communication**: Signals propagate properly
- **Alert system**: Bidirectional alert responses
- **Session persistence**: State survives system transitions

### **End-to-End Testing Scenarios**
1. **Complete Mission Flow**: Stealth → Terminal → TD → Results → Stealth
2. **Alert Cascading**: Stealth alert → TD response → Stealth response
3. **Concurrent Execution**: Both systems running, focus switching
4. **Mission Context**: Different mission types configure TD properly
5. **Error Recovery**: System failures don't break coordination

## 📋 Development Guidelines

### **Code Organization Principles**
1. **Minimal Parent Repo**: Keep coordination code lightweight and focused
2. **Self-Contained Submodules**: Each submodule must work independently
3. **Interface-Driven Communication**: Use signals and interfaces, never direct references
4. **State Persistence**: All important state must be serializable
5. **Error Isolation**: Failures in one system shouldn't crash the other

### **Naming Conventions**
- **Interfaces**: `[System]Interface.gd` (e.g., `StealthActionInterface.gd`)
- **Coordinators**: `[Function]Coordinator.gd` (e.g., `GameCoordinator.gd`)
- **Data Classes**: `[Type]Data.gd` or `[Type]Context.gd`
- **Signals**: Past tense verbs (e.g., `terminal_activated`, `alert_triggered`)

### **Signal Design Patterns**
- **Emit from child to parent**: Use signals for upward communication
- **Call methods from parent to child**: Use interface methods for downward communication
- **Include context data**: All signals should include relevant context dictionaries
- **Descriptive naming**: Signal names should clearly indicate what happened

## 🔄 Submodule Management

### **Updating Submodules**
```bash
# Update single submodule to latest commit
git submodule update --remote cybercrawler_basic_demo/tower-defense
git add cybercrawler_basic_demo/tower-defense
git commit -m "Update tower-defense to latest version"

# Update all submodules at once
git submodule update --remote --merge
git add .
git commit -m "Update all submodules to latest"
```

### **Working with Submodules**
```bash
# Initialize submodules after fresh clone
git submodule update --init --recursive

# Check submodule status
git submodule status

# Navigate into submodule for development
cd cybercrawler_basic_demo/tower-defense
# Make changes, commit, push
cd ../..
git add cybercrawler_basic_demo/tower-defense
git commit -m "Update tower-defense: [describe changes]"
```

## 🚀 Implementation Phases

### **Phase 1: Core Coordination Framework** ✅
- [x] Create `GameCoordinator` main scene and script
- [x] Implement basic submodule loading and initialization
- [x] Define interface contracts (`StealthActionInterface`, `TowerDefenseInterface`)
- [x] Create `MissionContext` data structure
- [x] Test basic submodule instantiation and communication

### **Phase 2: Session Management System** 🚧
- [ ] Implement `SessionManager` for state persistence
- [ ] Create `SessionData` structure for cross-system state
- [ ] Build save/load functionality for mission context
- [ ] Test session state persistence across system transitions

### **Phase 3: Alert System Integration** 📋
- [ ] Implement bidirectional alert signal routing
- [ ] Create `AlertState` coordination data structure
- [ ] Connect stealth alerts to TD difficulty modifiers
- [ ] Connect TD events to stealth security responses
- [ ] Test alert cascading and system responses

### **Phase 4: Terminal Communication Framework** 📋
- [ ] Define terminal → coordinator communication protocol
- [ ] Implement terminal signal routing in `GameCoordinator`
- [ ] Create TD system configuration based on terminal access
- [ ] Test terminal activation → TD system launch flow

### **Phase 5: Concurrent Execution Management** 📋
- [ ] Implement background execution modes for both systems
- [ ] Create focus switching between stealth and TD control
- [ ] Implement AI-driven background state management
- [ ] Test concurrent system execution and state synchronization

## 🔗 Related Documentation

- **Parent Repository Architecture**: [documentation/CyberCrawler_Parent_Project_Architecture.md](documentation/CyberCrawler_Parent_Project_Architecture.md)
- **Coordination Architecture**: [documentation_highlevel/Parent_Repository_Coordination_Architecture.md](documentation_highlevel/Parent_Repository_Coordination_Architecture.md)
- **Stealth-Action Architecture**: [cybercrawler_basic_demo/stealth-action/README.md](cybercrawler_basic_demo/stealth-action/README.md)
- **Tower Defense Architecture**: [cybercrawler_basic_demo/tower-defense/documentation_highlevel/CyberCrawler_Architecture_Design_Patterns.md](cybercrawler_basic_demo/tower-defense/documentation_highlevel/CyberCrawler_Architecture_Design_Patterns.md)

---

**This architecture ensures:**
- ✅ **Minimal coordination overhead** - Parent repo stays lightweight and focused
- ✅ **Self-contained submodules** - Each system manages its own complexity  
- ✅ **Concurrent execution** - Both systems can run simultaneously
- ✅ **Bidirectional communication** - Alerts and events flow between systems
- ✅ **Extensible design** - Easy to add new systems or modify existing ones
- ✅ **Testable architecture** - Clear interfaces enable comprehensive testing
- ✅ **Godot best practices** - Follows established patterns and recommendations
