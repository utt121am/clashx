# CLASHX — Manual Testing Checklist

Tracking acceptance criteria and manual test items across milestones.

| Test Item | Target Milestone | Status | Notes |
|---|---|---|---|
| Game launches cleanly on Ubuntu | V0.1 | **PASSED** | Verified with Godot 4.3 on Linux x86_64 (Mobile renderer) |
| Arena renders with floor and bounds | V0.1 | **PASSED** | 30x30 arena with boundaries and lighting |
| Both fighters spawn correctly | V0.1 | **PASSED** | P1 (-3, 0, 0) and P2 (+3, 0, 0) |
| Fighters face each other correctly | V0.1 | **PASSED** | P1 faces right (+X), P2 faces left (-X) |
| 3D Rigged Character Integration | V0.1 / V0.5 | **PASSED** | Integrated `cherecter.fbx` with skeleton, meshes, and looping animation |
| Distinguishable visuals & team tinting | V0.1 | **PASSED** | P1 glowing Blue/Cyan joints, P2 glowing Red/Crimson joints |
| Side-view 3D camera frames fighters | V0.1 | **PASSED** | Smooth tracking and distance adjustment |
| Player 1 controls only Player 1 | V0.2 | **PASSED** | Verified: P1 moves with A/D/W/S without affecting P2 |
| Player 2 controls only Player 2 | V0.2 | **PASSED** | Verified: P2 moves with Arrow keys without affecting P1 |
| Both players can move independently | V0.2 | **PASSED** | Full X-axis and Z-depth axis movement validated |
| Arena boundaries prevent falling/leaving | V0.2 | **PASSED** | Wall static bodies stop movement at arena perimeter |
| Dynamic auto-facing orientation | V0.2 | **PASSED** | Fighters turn around when crossing positions |
| Deceleration and idle transition | V0.2 | **PASSED** | Friction brings fighters to rest in IDLE state |
| Punch damage is correct (10 HP) | V0.3 | Pending | Scheduled for V0.3 |
| Kick damage is correct (20 HP) | V0.3 | Pending | Scheduled for V0.3 |
| Block reduces incoming damage (x0.25) | V0.3 | Pending | Scheduled for V0.3 |
| Attack hitboxes work correctly | V0.3 | Pending | Scheduled for V0.3 |
| No repeated damage on single attack | V0.3 | Pending | Scheduled for V0.3 |
| Health bars update correctly | V0.4 | Pending | Scheduled for V0.4 |
| Defeat detection works | V0.4 | Pending | Scheduled for V0.4 |
| Winner announcement displays | V0.4 | Pending | Scheduled for V0.4 |
| Restart restores both fighters | V0.4 | Pending | Scheduled for V0.4 |
| Pause and resume work | V0.4 | Pending | Scheduled for V0.4 |
| No unexpected runtime errors | Continuous | **PASSED** | Validated headlessly and on active display |
