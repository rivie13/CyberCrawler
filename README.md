# CyberCrawler

**A Stealth Action Tower Defense Game with Asymmetrical Warfare**

CyberCrawler is a unique hybrid game that combines 2.5D stealth action with strategic tower defense gameplay. Players infiltrate corporate networks as a hacker, moving stealthily through physical environments to access terminals where they jack into cyberspace to engage in tactical tower defense battles against rival AI systems.

## 🎮 Game Concept

### Core Gameplay Loop
1. **Stealth Phase**: Navigate through 2.5D environments, avoiding guards and security systems
2. **Network Breach**: Access terminals to jack into the corporate network 
3. **Tower Defense Phase**: Deploy programs and defenses to guide your data packet to the network core
4. **Rival Hacker**: Face off against an AI opponent that adapts and counters your strategies
5. **Return to Stealth**: Complete the hack and return to the physical world

### Key Features
- **Asymmetrical Warfare**: Player is outnumbered but uses cunning and strategy to overcome corporate defenses
- **Dynamic Alert System**: Actions in stealth mode affect tower defense difficulty, and vice versa
- **Multiple Terminals**: Players must work between different terminals for towers, mines, upgrades, and the main data packet terminal
- **Rival Hacker AI**: Intelligent opponent that places countermeasures, sends homing attacks, and dynamically alters the battlefield

## 🏗️ Multi-Repository Architecture

This is the **parent repository** that orchestrates the complete CyberCrawler experience through git submodules:

### Repository Structure
```
CyberCrawler/ (Parent Repository)
├── tower-defense/          # Submodule: Core TD gameplay system
├── stealth-action/         # Submodule: 2.5D stealth gameplay system  
├── hub-system/            # Submodule: Mission selection and upgrades
├── shared-assets/         # Submodule: Common assets and resources
└── integration-layer/     # Submodule: Cross-system communication
```

### Development Workflow
- **Git Flow**: `feature/bugfix/issue` → `dev` → `main`
- **Each submodule** follows independent development cycles
- **Integration testing** happens at the parent repository level
- **Cross-system communication** through well-defined interfaces

## 🎯 Design Pillars

### 1. The Ghost & The Machine
Players embody two distinct personas: a cunning "ghost" during stealth sections and a strategic "machine" during hacking sequences.

### 2. Asymmetrical Warfare  
The player is an underdog fighting a technological behemoth. Victory comes through cunning, sabotage, and exploiting system weaknesses rather than brute force.

### 3. A Living, Breathing Dystopia
The world tells a story of technological oppression and human rebellion through environmental storytelling, character interactions, and narrative integration.

## 🔧 Current Development Status

### Phase 1: Tower Defense Vertical Slice ✅
- [x] Interface-driven architecture with dependency injection
- [x] Core TD gameplay (towers, enemies, rival hacker AI)
- [x] Freeze mine tactical system
- [x] Program data packet win condition
- [x] Comprehensive test coverage

### Phase 2: Multi-Repo Architecture 🚧
- [x] Parent repository created
- [ ] Tower defense submodule integration
- [ ] Stealth action repository creation
- [ ] Cross-system communication interfaces

### Phase 3: Stealth Integration 📋
- [ ] 2.5D stealth action gameplay
- [ ] Terminal interaction system
- [ ] Alert system integration
- [ ] Mission context carryover

### Phase 4: Hub System 📋
- [ ] Mission selection interface
- [ ] Character progression systems
- [ ] Story progression tracking
- [ ] Save/load functionality

## 🛠️ Technical Architecture

### Core Technologies
- **Engine**: Godot 4.x
- **Architecture**: Interface-driven dependency injection
- **Testing**: GDScript unit and integration tests
- **Version Control**: Git with submodule orchestration

### Design Patterns
- **Manager Pattern**: Each system encapsulated in dedicated managers
- **Interface Contracts**: All systems define clear public APIs
- **Signal-Driven Communication**: Event-driven architecture for system interaction
- **Service Locator**: (Future) Global service access for complex interactions

## 📚 Documentation

- **Tower Defense Architecture**: See `tower-defense/` submodule documentation
- **Game Design Document**: Comprehensive design in repository docs
- **API Documentation**: Interface contracts and system interactions
- **Development Workflow**: Git flow and contribution guidelines

## 🚀 Getting Started

### Prerequisites
- Godot 4.x Engine
- Git with submodule support
- PowerShell (Windows) or compatible shell

### Setup Instructions
```bash
# Clone parent repository with all submodules
git clone --recursive https://github.com/username/CyberCrawler.git

# If already cloned, initialize submodules
git submodule update --init --recursive

# Enter development workflow
git checkout dev
git checkout -b feature/your-feature-name
```

### Running the Game
1. Open Godot 4.x
2. Import the project from the parent directory
3. Run the main scene to experience the integrated gameplay

## 🤝 Contributing

1. Follow the established git workflow: `feature` → `dev` → `main`
2. Maintain interface contracts for cross-system compatibility
3. Include comprehensive tests for new functionality
4. Update documentation for architectural changes

## 📄 License

[License information to be determined]

---

*CyberCrawler - Where stealth meets strategy in the digital underground.*
