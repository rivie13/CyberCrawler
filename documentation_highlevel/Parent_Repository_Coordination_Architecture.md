# CyberCrawler Parent Repository Coordination Architecture

**Version**: 1.0  
**Last Updated**: July 2025  
**Purpose**: Defines the minimal coordination architecture for orchestrating communication between stealth-action and tower-defense submodules

---

## 🎯 Core Philosophy: Minimal Coordination Only

The parent repository serves **ONLY** as a coordination layer between submodules. It does **NOT** contain game logic, scene objects, or gameplay systems. Following [Godot's scene organization best practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/scene_organization.html), each submodule manages its own state and objects.

### **What the Parent Repo IS:**
- ✅ **Coordination Hub**: Orchestrates communication between submodules
- ✅ **Session Manager**: Maintains cross-system state and mission context
- ✅ **Message Router**: Routes signals between stealth-action and tower-defense
- ✅ **Entry Point**: Provides the main scene that loads and initializes submodules

### **What the Parent Repo is NOT:**
- ❌ **Game Logic Container**: No gameplay mechanics or systems
- ❌ **Scene Object Manager**: No terminals, players, enemies, or UI elements  
- ❌ **Asset Repository**: No textures, audio, or scene files
- ❌ **Dependency Provider**: Submodules must be self-contained

---

## 🏗️ Repository Structure

```
CyberCrawler/ (Parent Repository)
├── main.tscn                        # Entry point scene
├── scripts/
│   ├── GameCoordinator.gd           # Main orchestrator (minimal)
│   ├── SessionManager.gd            # Cross-system state persistence
│   ├── interfaces/
│   │   ├── StealthActionInterface.gd    # Communication interface to stealth submodule
│   │   └── TowerDefenseInterface.gd     # Communication interface to TD submodule
│   └── data/
│       ├── MissionContext.gd            # Mission parameters and context
│       ├── SessionData.gd               # Cross-system session state
│       └── AlertState.gd                # Alert system coordination data
├── tower-defense/                   # Git submodule - TD game system
├── stealth-action/                  # Git submodule - 2.5D stealth game system
└── documentation/
    ├── Parent_Repository_Coordination_Architecture.md  # This document
    ├── Communication_Protocols.md                      # Signal/interface specs
    └── Integration_Testing_Guide.md                    # Testing coordination
```

---

## 🎮 Game Systems Ownership

### **Stealth-Action Submodule Owns:**
- **Player Character**: Movement, stealth mechanics, interaction systems
- **2.5D World**: Levels, environments, collision detection
- **Terminal Objects**: Physical terminals in the stealth world (scenes + scripts)
- **Security Systems**: Guards, cameras, patrol routes, alert detection
- **Stealth UI**: HUD, interaction prompts, stealth indicators
- **Level Design**: Room layouts, terminal placement, security configuration

### **Tower-Defense Submodule Owns:**
- **TD Gameplay**: All existing TD mechanics and systems
- **Manager Architecture**: Current interface-driven system remains unchanged
- **TD UI**: Tower placement interface, resource displays, game state UI
- **Background Execution**: Ability to run without player input
- **Alert Integration**: Receives alert parameters, adjusts difficulty accordingly

### **Parent Repository Owns:**
- **System Initialization**: Loading and starting both submodules
- **Cross-System Communication**: Signal routing between submodules
- **Mission Context**: Shared data that affects both systems
- **Session State**: Persistent state across system transitions
- **Alert Coordination**: Routing alerts between stealth and TD systems

---

## 🔄 Concurrent Execution Architecture

### **Core Principle: Both Systems Always Active**

Unlike traditional single-system games, CyberCrawler runs both stealth-action and tower-defense systems concurrently once TD is activated.

```
Game Launch
    ↓
┌─ Stealth-Action: ACTIVE (Player Control) ─┐
│  - Player moves in 2.5D world            │
│  - Stealth mechanics active              │
│  - Terminals available for interaction   │
└────────────────────────────────────────────┘
            │
            │ Player activates Terminal
            ↓
┌─ Stealth-Action: ACTIVE (Background AI) ──┐  ┌─ Tower Defense: ACTIVE (Player Control) ─┐
│  - AI maintains stealth world state      │  │  - Player controls TD interface           │
│  - Security systems continue operating   │  │  - Waves, towers, rival hacker active    │
│  - Guards maintain patrol patterns       │  │  - Full TD gameplay mechanics            │
│  - Alert system monitors both systems    │◄─┤  - Can trigger alerts to stealth side   │
└───────────────────────────────────────────┘  └────────────────────────────────────────────┘
            ▲                                              │
            │            Player switches focus             │
            └──────────────────────────────────────────────┘
```

### **System States:**

| State | Stealth-Action | Tower-Defense | Description |
|-------|----------------|---------------|-------------|
| **Initial** | Active (Player) | Inactive | Game starts, player in stealth world |
| **TD Activated** | Active (Background) | Active (Player) | Player activated TD at terminal |
| **Concurrent** | Active (Background) | Active (Background) | Both systems running, can switch focus |
| **Mission Complete** | Active (Player) | Inactive | TD mission completed, back to stealth only |

---

## 📡 Communication Architecture

### **Signal-Based Communication Pattern**

Following Godot's [dependency injection principles](https://docs.godotengine.org/en/stable/tutorials/best_practices/scene_organization.html#how-to-build-relationships-effectively), submodules communicate through interfaces and signals, not direct references.

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

---

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

### **Alert Types & Responses**

| Alert Source | Alert Type | Stealth Response | TD Response |
|--------------|------------|------------------|-------------|
| **Player spotted** | HIGH | Increase guard activity | Activate rival hacker |
| **Terminal accessed** | MEDIUM | Security scan activated | Increase wave difficulty |
| **Rival hacker activated** | HIGH | Alert all guards | Continue TD pressure |
| **TD mission failed** | LOW | Reduce security temporarily | Reset TD state |
| **Program packet released** | CRITICAL | Maximum security alert | Victory condition |

---

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

### **Terminal Types & TD System Mapping**

| Terminal Type | Security Level | TD System Interface | Alert Risk |
|---------------|----------------|---------------------|------------|
| **Main Terminal** | Maximum | `ProgramDataPacketManagerInterface` | Critical |
| **Tower Terminal** | High | `TowerManagerInterface` | High |
| **Mine Terminal** | Medium | `MineManagerInterface` | Medium |
| **Upgrade Terminal** | Medium | `CurrencyManagerInterface` | Low |
| **Monitor Terminal** | Low | `GameManagerInterface` (read-only) | None |

---

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

### **Session State Persistence**

```gdscript
class_name SessionManager
extends Node

var current_mission: MissionContext
var stealth_persistent_state: Dictionary
var td_persistent_state: Dictionary

# Core session management
func start_new_session(mission_config: Dictionary) -> MissionContext
func save_session_state() -> Dictionary
func load_session_state(save_data: Dictionary) -> bool
func cleanup_session() -> void

# Cross-system state synchronization
func sync_stealth_state(state_data: Dictionary) -> void
func sync_td_state(state_data: Dictionary) -> void  
func get_cross_system_context() -> Dictionary
func merge_mission_results(results: Dictionary) -> Dictionary
```

---

## 🚀 Implementation Phases

### **Phase 1: Core Coordination Framework**
- [ ] Create `GameCoordinator` main scene and script
- [ ] Implement basic submodule loading and initialization
- [ ] Define interface contracts (`StealthActionInterface`, `TowerDefenseInterface`)
- [ ] Create `MissionContext` data structure
- [ ] Test basic submodule instantiation and communication

### **Phase 2: Session Management System**
- [ ] Implement `SessionManager` for state persistence
- [ ] Create `SessionData` structure for cross-system state
- [ ] Build save/load functionality for mission context
- [ ] Test session state persistence across system transitions

### **Phase 3: Alert System Integration**
- [ ] Implement bidirectional alert signal routing
- [ ] Create `AlertState` coordination data structure
- [ ] Connect stealth alerts to TD difficulty modifiers
- [ ] Connect TD events to stealth security responses
- [ ] Test alert cascading and system responses

### **Phase 4: Terminal Communication Framework**
- [ ] Define terminal → coordinator communication protocol
- [ ] Implement terminal signal routing in `GameCoordinator`
- [ ] Create TD system configuration based on terminal access
- [ ] Test terminal activation → TD system launch flow

### **Phase 5: Concurrent Execution Management**
- [ ] Implement background execution modes for both systems
- [ ] Create focus switching between stealth and TD control
- [ ] Implement AI-driven background state management
- [ ] Test concurrent system execution and state synchronization

### **Phase 6: Integration Testing & Polish**
- [ ] Complete end-to-end stealth → TD → stealth cycle testing
- [ ] Performance optimization for concurrent execution
- [ ] Error handling and recovery systems
- [ ] Documentation updates and code review

---

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

---

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

---

## 🔗 Related Documentation

- **Communication Protocols**: [Communication_Protocols.md](Communication_Protocols.md)
- **Integration Testing Guide**: [Integration_Testing_Guide.md](Integration_Testing_Guide.md)  
- **Stealth-Action Architecture**: [stealth-action/README.md](stealth-action/README.md)
- **Tower Defense Architecture**: [tower-defense/documentation_highlevel/CyberCrawler_Architecture_Design_Patterns.md](tower-defense/documentation_highlevel/CyberCrawler_Architecture_Design_Patterns.md)

---

## 📝 Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| July 2025 | Terminals belong in stealth-action repo | Terminals are physical objects in stealth world, not coordination logic |
| July 2025 | Concurrent execution architecture | Both systems must run simultaneously for true "living world" experience |
| July 2025 | Minimal parent repo approach | Follows Godot best practices, reduces complexity, improves maintainability |
| July 2025 | Signal-based communication | Loose coupling, follows Godot patterns, enables better testing |

---

**This architecture ensures:**
- ✅ **Minimal coordination overhead** - Parent repo stays lightweight and focused
- ✅ **Self-contained submodules** - Each system manages its own complexity  
- ✅ **Concurrent execution** - Both systems can run simultaneously
- ✅ **Bidirectional communication** - Alerts and events flow between systems
- ✅ **Extensible design** - Easy to add new systems or modify existing ones
- ✅ **Testable architecture** - Clear interfaces enable comprehensive testing
- ✅ **Godot best practices** - Follows established patterns and recommendations 