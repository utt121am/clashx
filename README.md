# CLASHX

> **Two Fighters. One Winner.**

A modular, local two-player 3D fighting game prototype built in **Godot 4.x** with typed GDScript for Ubuntu Linux desktop.

---

## Architecture Overview

```
CLASHX/
├── project.godot                     # Godot 4.3 project configuration (InputMap, renderer)
├── README.md                         # Project documentation
├── .gitignore                        # Git ignore patterns
│
├── assets/
│   └── characters/
│       └── cherecter.fbx             # Rigged 3D humanoid character model
│
├── scenes/
│   ├── main/
│   │   └── main.tscn                 # Main fighting scene
│   ├── arena/
│   │   └── arena.tscn                # 30x30 Arena with boundaries
│   ├── fighter/
│   │   └── fighter.tscn              # Reusable Fighter scene with 3D character model
│   ├── tests/
│   │   └── test_v02.tscn             # In-engine physics & movement test scene
│   └── ui/                           # HUD & Result screens (Milestone V0.4)
│
├── scripts/
│   ├── fighter/
│   │   ├── fighter.gd                # Movement physics, state machine, auto-facing, materials
│   │   └── fighter_input.gd          # Decoupled input component (p1_/p2_ prefixes)
│   ├── camera/
│   │   └── fighting_camera.gd        # Dynamic side-view 3D camera
│   ├── combat/                       # Combat system (Milestone V0.3)
│   └── ui/                           # UI controllers (Milestone V0.4)
│
└── tests/
    ├── manual_test_checklist.md      # Testing matrix & status
    ├── test_v01.gd                   # Automated V0.1 test suite
    └── test_v02.gd                   # Automated V0.2 test runner
```

---

## Milestones & Status

- [x] **V0.1 — Project Foundation**
  - Godot 4.3 setup and project initialization.
  - 30x30 3D fighting arena with floor and boundary collisions.
  - Reusable `Fighter` scene with distinct P1 (Blue) and P2 (Red) visuals.
  - Dynamic side-view 3D camera tracking both fighters.
- [x] **V0.2 — Player Movement & 3D Character Integration**
  - Integrated `cherecter.fbx` rigged humanoid with skeleton and looped animation.
  - Applied team material shaders: glowing Blue joints for P1, glowing Red joints for P2.
  - Configured full Godot InputMap for Player 1, Player 2, and Globals.
  - Decoupled `FighterInput` component with prefix mapping.
  - Independent horizontal (X) and depth lane (Z) movement with acceleration and friction.
  - Dynamic auto-facing orientation keeping fighters facing each other.
  - Boundary collision enforcement preventing exit from the arena.
- [ ] **V0.3 — Combat System (Punch, Kick, Block, Hitboxes)**
- [ ] **V0.4 — Game UI & Match Flow (HUD, Defeat, Restart)**
- [ ] **V0.5 — Additional Animations and Audio**
- [ ] **V1.0 — Final Playable Game & Polish**

---

## Controls Reference

### Player 1
- **Move Left / Right**: `A` / `D`
- **Move Forward / Backward (Depth)**: `W` / `S`
- **Punch**: `F` *(V0.3)*
- **Kick**: `G` *(V0.3)*
- **Block**: `H` *(V0.3)*

### Player 2
- **Move Left / Right**: `Left` / `Right` Arrow keys
- **Move Forward / Backward (Depth)**: `Up` / `Down` Arrow keys
- **Punch**: `K` *(V0.3)*
- **Kick**: `L` *(V0.3)*
- **Block**: `;` (Semicolon) *(V0.3)*

### Global Controls
- **Pause**: `Escape`
- **Restart**: `Enter`

---

## Running the Game

To launch the playable game on Ubuntu:
```bash
cd /home/uttamnayek/Work_uttam/clashx
godot
```

To run the automated validation test suites:
```bash
godot --headless -s tests/test_v01.gd
godot --headless -s tests/test_v02.gd
```
