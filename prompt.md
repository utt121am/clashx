
# CLASHX — 3D Human Fighting Game

**Tagline:** Two Fighters. One Winner.

## 1. Project Overview

Develop CLASHX, a basic but fully playable 3D human-versus-human fighting game.

The game will feature two human fighters competing against each other in a small 3D fighting arena.

The initial version must support local multiplayer, where two players use the same computer and keyboard.

### Main Features

- Two playable human characters.
- 3D fighting arena.
- Hand-to-hand combat.
- Punch, kick and block.
- Independent player movement.
- Health and damage system.
- Character animations.
- Health bars.
- Victory and defeat screens.
- Pause and restart functionality.

### Out of Scope for V1

- Online multiplayer.
- User authentication.
- Backend APIs.
- Database.
- Open-world environment.
- Advanced physics.
- Complex character progression.

Focus on building a stable, playable fighting game.

---

## 2. Technology Stack

Use the following technology stack.

| Component | Technology |
|---|---|
| Game Engine | Godot 4.x |
| Programming Language | GDScript |
| Rendering | Godot Mobile Renderer |
| Physics | Godot Physics |
| Animation | AnimationPlayer + AnimationTree |
| 3D Modelling | Blender |
| Character Assets | Mixamo / Sketchfab |
| IDE | Godot Editor + Antigravity |
| Version Control | Git + GitHub |
| Target Platform | Ubuntu Desktop |

### Technology Guidelines

- Use Godot-native functionality wherever possible.
- Prefer typed GDScript.
- Avoid unnecessary third-party dependencies.
- Use reusable scenes and components.
- Keep the project modular and maintainable.

---

## 3. Game Design

### Game Mode

Local Multiplayer — Two Players on One Computer.

Both players control their own human character using the keyboard.

### Camera

Use a side-view 3D fighting camera.

Requirements:

- Both fighters must remain visible.
- Camera should smoothly follow the fighting area.
- Camera should adjust its distance based on the fighters' positions.
- Use a 3D environment and 3D character models.
- Keep the fighting plane easy to understand.

### Fighting Style

Hand-to-hand combat.

Each fighter must support:

- Idle.
- Walking.
- Punching.
- Kicking.
- Blocking.
- Taking damage.
- Defeat.

---

## 4. Player Controls

### Player 1

| Action | Key |
|---|---|
| Move Left | A |
| Move Right | D |
| Move Forward | W |
| Move Backward | S |
| Punch | F |
| Kick | G |
| Block | H |

### Player 2

| Action | Key |
|---|---|
| Move Left | Left Arrow |
| Move Right | Right Arrow |
| Move Forward | Up Arrow |
| Move Backward | Down Arrow |
| Punch | K |
| Kick | L |
| Block | Semicolon |

### Global Controls

| Action | Key |
|---|---|
| Pause | Escape |
| Restart | Enter |

Use Godot Input Map actions instead of hardcoding key checks throughout the game.

---

## 5. Initial Game Configuration

Use these values as initial configurable defaults.

| Setting | Value |
|---|---|
| Starting Health | 100 |
| Punch Damage | 10 |
| Kick Damage | 20 |
| Block Damage Multiplier | 0.25 |
| Arena Size | 30 x 30 units |
| Target FPS | 60 |
| Initial Resolution | 1280 x 720 |
| Number of Players | 2 |
| Game Mode | Local Multiplayer |

All gameplay values should be configurable.

---

## 6. Project Architecture

Create a modular and reusable architecture.

Suggested project structure:

CLASHX/
│
├── project.godot
├── README.md
├── .gitignore
│
├── scenes/
│   ├── main/
│   │   └── main.tscn
│   │
│   ├── arena/
│   │   └── arena.tscn
│   │
│   ├── fighter/
│   │   └── fighter.tscn
│   │
│   └── ui/
│       ├── hud.tscn
│       └── result_screen.tscn
│
├── scripts/
│   ├── game_manager.gd
│   │
│   ├── fighter/
│   │   ├── fighter.gd
│   │   ├── fighter_input.gd
│   │   ├── fighter_state_machine.gd
│   │   └── fighter_stats.gd
│   │
│   ├── combat/
│   │   └── combat_system.gd
│   │
│   ├── camera/
│   │   └── fighting_camera.gd
│   │
│   └── ui/
│       └── hud.gd
│
├── assets/
│   ├── characters/
│   ├── animations/
│   ├── arena/
│   ├── materials/
│   └── audio/
│
└── tests/
    └── manual_test_checklist.md

Modify this structure when necessary, but keep the architecture clean.

Do not create unnecessary empty files.

---

## 7. Fighter Architecture

Create one reusable Fighter scene.

Instantiate it twice:

- Fighter 1.
- Fighter 2.

Both fighters must use the same underlying logic.

Each fighter must have:

- CharacterBody3D.
- CollisionShape3D.
- Character visual model.
- AnimationPlayer or AnimationTree.
- Health component.
- Combat hitbox.
- Input configuration.
- Facing direction.
- Combat state.

Each fighter must maintain independent:

- Health.
- Position.
- Movement.
- Attack state.
- Blocking state.
- Animation state.

Use configurable input mappings to distinguish the two players.

---

## 8. Combat System

Implement a centralized combat system.

### Punch

- Short-range attack.
- Damage: 10 HP.
- Short attack duration.
- Appropriate punch animation.

### Kick

- Slightly longer-range attack.
- Damage: 20 HP.
- Longer recovery time.
- Appropriate kick animation.

### Block

- Reduces incoming damage.
- Block damage multiplier: 0.25.
- Appropriate defensive animation.

### Hit Detection

Use Area3D and attack-specific hitboxes.

Requirements:

1. Attack hitboxes must only be active during the attack's active frames.
2. Damage must only apply when the opponent is within the valid attack area.
3. One attack should not repeatedly damage the same opponent every frame.
4. Blocking must reduce damage correctly.
5. Attack startup, active and recovery periods must be implemented.
6. The same attack must not damage multiple times accidentally.

Keep damage calculation centralized.

---

## 9. Fighter State Machine

Implement a state machine to control fighter actions.

Initial states:

- IDLE
- MOVING
- PUNCHING
- KICKING
- BLOCKING
- HIT
- KNOCKDOWN
- DEFEATED

Requirements:

- Prevent incompatible actions from running simultaneously.
- Prevent attacks while the fighter is defeated.
- Prevent new attacks during attack recovery.
- Handle transitions between movement, combat and hit reactions.
- Keep state transition logic separate from visual animation logic.

---

## 10. Game Manager

The Game Manager must control the overall match.

Responsibilities:

- Initialize the match.
- Spawn both fighters.
- Track match state.
- Detect player defeat.
- Determine the winner.
- Pause and resume the match.
- Restart the match.
- Update the result screen.

Match states:

- READY
- FIGHTING
- PAUSED
- FINISHED

The Game Manager owns match rules.

The UI should only display game information.

---

## 11. Camera System

Create a dedicated fighting camera.

Requirements:

- Side-view 3D perspective.
- Both fighters should remain visible.
- Smooth camera movement.
- Automatic camera distance adjustment.
- Avoid unnecessary camera shaking.
- Maintain a comfortable viewing angle.

---

## 12. UI Design

Create a simple fighting game interface.

### Main Menu

Display:

- CLASHX logo/title.
- Start Fight.
- Exit Game.

### Battle HUD

Display:

- Player 1 name.
- Player 1 health bar.
- Player 2 name.
- Player 2 health bar.
- Pause button.
- Match status.

### Result Screen

Display:

- Winner announcement.
- Restart button.
- Main Menu button.

Keep the interface clean and readable.

---

## 13. Character Assets and Animations

Use low-poly or optimized 3D human characters.

For the initial prototype, placeholder characters are acceptable.

Use suitable animation assets for:

1. Idle.
2. Walk.
3. Punch.
4. Kick.
5. Block.
6. Hit reaction.
7. Defeat.

Possible asset resources:

- Mixamo.
- Sketchfab.
- Kenney Assets.
- Blender.

Check the licence and usage permissions of every downloaded asset.

Do not wait for final character models before implementing gameplay.

The initial game must work with placeholder models.

---

## 14. Performance Optimization

Follow these optimization guidelines:

- Use low-poly character models.
- Prefer simple collision shapes.
- Avoid detailed mesh-based collision for fighters.
- Limit real-time shadows.
- Use optimized textures.
- Avoid unnecessary per-frame calculations.
- Avoid repeated scene-tree searches.
- Use signals for important gameplay events.
- Use a single shared fighting camera.
- Avoid unnecessary visual effects.
- Test the Mobile renderer on integrated graphics.
- Consider Forward+ only if hardware performance allows.

Target stable performance around 60 FPS on supported desktop hardware.

Do not sacrifice gameplay correctness for premature optimization.

---

## 15. Development Milestones

Develop the game incrementally.

### V0.1 — Project Foundation

- Create Godot project.
- Create main scene.
- Create 3D arena.
- Add ground and boundaries.
- Add two placeholder human fighters.
- Configure lighting.
- Implement side-view camera.

Acceptance Criteria:

Both fighters and the arena render correctly.

### V0.2 — Player Movement

- Implement Player 1 movement.
- Implement Player 2 movement.
- Configure independent controls.
- Implement facing direction.
- Prevent leaving arena boundaries.

Acceptance Criteria:

Both players can move independently.

### V0.3 — Combat System

- Implement punch.
- Implement kick.
- Implement block.
- Implement attack hitboxes.
- Implement damage calculation.
- Implement health management.

Acceptance Criteria:

Both players can attack and defend successfully.

### V0.4 — Game UI

- Implement health bars.
- Implement pause.
- Implement restart.
- Implement winner detection.
- Implement result screen.

Acceptance Criteria:

A complete match can start, finish and restart.

### V0.5 — Animations and Audio

- Add character models.
- Add character animations.
- Add impact sounds.
- Add simple visual effects.
- Improve camera behaviour.

Acceptance Criteria:

Fighting actions have appropriate visual and audio feedback.

### V1.0 — Final Playable Game

- Verify all controls.
- Verify all combat mechanics.
- Fix gameplay bugs.
- Optimize performance.
- Verify restart and match flow.
- Document installation and execution.

---

## 16. Testing Requirements

Maintain a manual testing checklist.

Test the following:

- Game launches on Ubuntu.
- Both fighters spawn correctly.
- Player 1 controls only Player 1.
- Player 2 controls only Player 2.
- Both players can move.
- Fighters face each other correctly.
- Arena boundaries work.
- Punch damage is correct.
- Kick damage is correct.
- Block reduces incoming damage.
- Attack hitboxes work correctly.
- No repeated damage occurs from one attack.
- Health bars update correctly.
- Defeat detection works.
- Winner announcement is correct.
- Restart restores both fighters.
- Pause and resume work.
- No unexpected runtime errors occur.

---

## 17. Instructions for Antigravity AI

Act as a professional Godot game developer.

Follow these development rules:

1. Inspect the existing workspace before modifying anything.
2. Check whether Godot 4.x is installed.
3. Report the detected Godot version.
4. Use Godot 4.x and GDScript.
5. Follow the architecture described in this document.
6. Use reusable scenes and scripts.
7. Write clean, modular and maintainable code.
8. Use typed GDScript where appropriate.
9. Do not put the entire game inside one script.
10. Do not generate the entire project in one untested step.
11. Implement one milestone at a time.
12. Run the project after implementing each milestone.
13. Fix errors before continuing.
14. Do not claim a feature works without testing it.
15. Preserve existing working functionality.
16. Explain all important files and changes.
17. Keep the README updated.
18. Do not add backend, database or online multiplayer in V1.
19. Use placeholder assets when final assets are unavailable.
20. Ask before introducing paid assets or external services.

---

## 18. FIRST TASK — Start Development

Start with V0.1 only.

### Required Deliverables

1. Create a runnable Godot 4.x project named CLASHX.
2. Create a main scene.
3. Create a simple 3D fighting arena.
4. Add two distinguishable placeholder human fighters.
5. Add appropriate lighting.
6. Add a side-view 3D camera.
7. Organize the project files properly.
8. Run the project and verify that the scene works.
9. Report the files created and any issues.

### Important Restrictions

- Do not implement combat yet.
- Do not implement player movement yet.
- Do not implement online multiplayer.
- Do not generate unnecessary features.
- Do not move to V0.2 until V0.1 has been verified.

**Final objective:** Build a clean, runnable foundation for CLASHX before adding gameplay mechanics.

---

**PROJECT NAME: CLASHX**

**TAGLINE: TWO FIGHTERS. ONE WINNER.**
