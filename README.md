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

## 🔄 Updating Submodules

### Quick Update Commands

**Update single submodule to latest commit:**
```bash
git submodule update --remote tower-defense
git add tower-defense
git commit -m "Update tower-defense to latest version"
```

**Update all submodules at once:**
```bash
git submodule update --remote --merge
git add .
git commit -m "Update all submodules to latest"
```

### Complete Update Workflow

#### Step 1: Check Current Submodule Status
```bash
# See current status of all submodules
git submodule status

# Check which branch each submodule is tracking
cat .gitmodules
```

#### Step 2: Update to Latest Commit on Tracked Branch
```bash
# Update specific submodule (recommended)
git submodule update --remote tower-defense

# Alternative: Navigate into submodule and pull directly
cd tower-defense
git pull origin main
cd ..
```

#### Step 3: Commit the Updated Reference
```bash
# Stage the submodule changes
git add tower-defense

# Commit with descriptive message
git commit -m "Update tower-defense to latest commit"

- Updated to include latest features/fixes from TD repo
- Version: [insert commit hash or version info]"
```

#### Step 4: Push Changes
```bash
# Push to your current feature branch
git push origin feature/your-feature-name

# Or push to dev branch after merging
git push origin dev
```

### Advanced Submodule Operations

#### Update to Specific Commit
```bash
# Method 1: Traditional approach
cd tower-defense
git checkout <specific-commit-hash>
cd ..
git add tower-defense
git commit -m "Update tower-defense to specific commit <hash>"

# Method 2: Direct hash update (one-liner)
git update-index --cacheinfo 160000 <commit-hash> tower-defense
git commit -m "Update tower-defense to commit <hash>"
```

#### Initialize Submodules After Fresh Clone
```bash
# Clone parent repo with all submodules
git clone --recursive https://github.com/username/CyberCrawler.git

# Or if already cloned, initialize submodules
git submodule update --init --recursive
```

#### Sync Submodule URLs (if changed)
```bash
# Sync .gitmodules configuration to .git/config
git submodule sync --recursive

# Then update to pull from new URLs
git submodule update --init --recursive
```

### Best Practices for Submodule Management

#### 1. **Regular Updates**
- Update submodules regularly to get latest fixes and features
- Check submodule status before starting new work: `git submodule status`
- Use descriptive commit messages when updating submodule references

#### 2. **Branch Tracking**
- Each submodule is configured to track the `main` branch
- This enables automatic updates with `git submodule update --remote`
- Branch configuration is stored in `.gitmodules` file

#### 3. **Development Workflow**
```bash
# When working on tower defense changes:
# 1. Make changes in separate tower defense repo
# 2. Push changes to tower defense repo
# 3. Update parent repo to reference new commit

# Example workflow:
cd /path/to/separate/tower-defense-repo
# Make changes, commit, push

cd /path/to/CyberCrawler
git submodule update --remote tower-defense
git add tower-defense
git commit -m "Update tower-defense: [describe changes]"
```

#### 4. **Team Collaboration**
- Always commit submodule reference updates after pulling changes
- Use `git submodule update --init --recursive` when pulling parent repo changes
- Communicate submodule updates to team members

#### 5. **Version Control Strategy**
- Tag important submodule versions for stability
- Consider pinning submodules to specific commits for releases
- Use feature branches for experimental submodule updates

### Troubleshooting Common Issues

#### Submodule Changes Not Showing
```bash
# Ensure submodule is properly initialized
git submodule update --init tower-defense

# Check if submodule is in detached HEAD state
cd tower-defense
git branch -a
git checkout main  # if needed
```

#### Merge Conflicts in Submodules
```bash
# If submodule has merge conflicts
cd tower-defense
git checkout main  # Reset to clean state
cd ..
git add tower-defense
```

#### Reset Submodule to Clean State
```bash
# Reset submodule to match parent repo's recorded commit
git submodule update --force tower-defense
```

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
- [x] Tower defense submodule integration (tracking main branch)
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
5. **Update submodules regularly** and commit reference changes
6. Use descriptive commit messages for submodule updates

## 📄 License

CyberCrawler is released under the **CyberCrawler Source Available License v1.0**.

**What this means:**
- ✅ **Learning & Education**: View, study, and learn from the source code
- ✅ **Non-Commercial Use**: Modify and create derivative works for personal/educational purposes  
- ✅ **Community Collaboration**: Contribute to the project and help with development
- ❌ **Commercial Use**: Requires separate commercial license (contact: riviera.t.sperduto13@gmail.com)

This license allows collaborative development while protecting commercial rights. See [LICENSE](LICENSE) for full terms.

---

*CyberCrawler - Where stealth meets strategy in the digital underground.*
