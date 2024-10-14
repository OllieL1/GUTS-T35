### Project: **Switch**
📌 **Prompt given by JP Morgan:** 
This is our submission for the Do you have the GUTS Hackathon 2024. We were given a prompt by JP Morgan to: 
_Make a fun game as simple as possible_
Our challenge this year is to create the most fun game with the least amount of effort from the user.
Options but not limited to:
Maybe an addictive game (E.g. Flappy Bird) which is only one button or an arcade game using directional buttons
Maybe a text-based escape room with simple options for the user to pick
There is no right answer here, we want to see what you come up with.

**Team Members**:
☎️ Ollie Livingston (https://github.com/OllieL1)
⚙️ Adam Tong (https://github.com/AdamTong04)
📼 Alasdair Findlay (https://github.com/ASFindlay)
🎥 Callum Cooper Lee (https://github.com/callumcooperlee)

📨 **Our submission:**
We decided to centre our focus on the "one touch" idea and create an addictive one tap game. We wanted to use gravity and the idea that the user was falling but solidfying this idea was tricky. Instead we opted to make the character directed towards one wall with obstacles falling towards them. The character would have to adjust their direction to dodge them. 
A big focus was making the design very visually pleasing to make the users experience very enjoyable and the game easy on the eye. 

### App Store Links
Coming soon ⌛

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
