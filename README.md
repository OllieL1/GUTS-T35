### Project: **Switch**

### To-Do List:

#### 1. **Core Game Mechanics**
   - [ ] Implement player movement with fixed upward speed and switchable horizontal gravity.
   - [ ] Add acceleration towards walls and momentum change when switching gravity.
   - [ ] Set collision detection with walls, allowing the player to "stick" and move upward on the wall.
   - [ ] Define obstacle behavior (spikes, etc.) that can appear either on walls or in mid-air.
   - [ ] Create game-over logic when the player hits an obstacle.

#### 2. **Level Design**
   - [ ] Design an endless-scrolling map with walls and varying gaps.
   - [ ] Implement biome changes where the game speed increases, and new obstacles are introduced.
   - [ ] Set up transitions between biomes with visual and gameplay changes.

#### 3. **Power-Ups**
   - [ ] Define power-up types (e.g., speed boost, shield, slow-motion).
   - [ ] Implement the **Decorator Pattern** for applying power-ups to the player.
   - [ ] Create logic for timed effects (e.g., boost duration, shield expiration).
   - [ ] Add power-up spawn points in the environment.

#### 4. **Obstacle Generation**
   - [ ] Implement a random obstacle generation system for variety in gameplay.
   - [ ] Adjust obstacle difficulty scaling based on progress and biome.

#### 5. **Polish and Visuals**
   - [ ] Create visuals for player, walls, obstacles, and power-ups.
   - [ ] Design visual cues for biome transitions (e.g., color shifts, new background elements).
   - [ ] Add screen shake and visual effects for gravity switches and momentum changes.
   - [ ] Implement particle effects for power-ups and player death.

#### 6. **Sound and Music**
   - [ ] Add sound effects for gravity switching, obstacle hits, power-up pickups.
   - [ ] Create or source background music that adapts to the biome.

#### 7. **Endless Mode Logic**
   - [ ] Create a score system based on time survived or distance traveled.
   - [ ] Add increasing difficulty based on player progress (speed up obstacles, reduce reaction times).

#### 8. **UI/UX**
   - [ ] Implement a start menu, pause screen, and game over screen.
   - [ ] Show current score and high score during gameplay.
   - [ ] Add tutorial or visual indicators to teach the player how to switch gravity.

#### 9. **Testing and Optimization**
   - [ ] Test for smooth performance across devices.
   - [ ] Debug collision, player movement, and obstacle generation.
   - [ ] Optimize graphics and assets for mobile performance.