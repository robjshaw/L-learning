# Day 2 Implementation Plan - Math Bubble Shooting Game

## Game Concept Overview
A math learning game where:
- **Dog character** (player) moves left/right at bottom of screen
- **Math question bubbles** fall from top of screen
- **Dog shoots projectiles** upward to hit bubbles
- **Player answers** by hitting the bubble with correct answer
- **Score increases** for correct hits, decreases for wrong hits
- **Header** explains game and connection to NGA poster

---

## Current State (What We've Built)
✅ Dog class with detailed visual design
✅ Keyboard controls: LEFT/RIGHT arrow keys
✅ Background image loaded

**What we need to add:**
- UP/DOWN controls (or remove them for this game)
- Projectile shooting system
- Math bubble class
- Collision detection
- Scoring system
- Game header/instructions

---

## Today's Implementation Tasks

### Task 1: Complete Player Movement (10 min)
**Goal:** Finalize dog movement along bottom of screen

**Implementation:**
```java
void keyPressed() {
   if (keyCode == LEFT && myDog.x > 40) {
      myDog.x -= 8;  // Move left (bounded)
   }
   if (keyCode == RIGHT && myDog.x < width - 40) {
      myDog.x += 8;  // Move right (bounded)
   }
}
```

**Changes from yesterday:**
- Keep dog at bottom: set initial y to `height - 60` in setup
- Only allow LEFT/RIGHT movement (remove UP/DOWN)
- Add boundaries so dog stays on screen

**Test:** Dog moves left/right along bottom, can't go off screen

---

### Task 2: Create Projectile Class (20-25 min)
**Goal:** Dog can shoot projectiles upward

**New Class:**
```java
class Projectile {
   float x, y;
   float speed;
   boolean active;

   Projectile(float startX, float startY) {
      x = startX;
      y = startY;
      speed = 5;
      active = true;
   }

   void move() {
      y -= speed;  // Move upward

      // Deactivate if off screen
      if (y < 0) {
         active = false;
      }
   }

   void display() {
      fill(255, 255, 0);  // Yellow projectile
      ellipse(x, y, 10, 10);
   }
}
```

**In main sketch:**
```java
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

void keyPressed() {
   // Existing movement code...

   // Shoot projectile with SPACE bar
   if (key == ' ') {
      projectiles.add(new Projectile(myDog.x + 40, myDog.y - 30));
   }
}

void draw() {
   image(backgroundImg, 0, 0, width, height);
   myDog.display();

   // Update and display projectiles
   for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile p = projectiles.get(i);
      p.move();
      p.display();

      // Remove inactive projectiles
      if (!p.active) {
         projectiles.remove(i);
      }
   }
}
```

**Learning Focus:**
- ArrayList for dynamic list management
- Object lifecycle (creation, active, removal)
- Iterating backwards to safely remove items

**Test:** Press SPACE to shoot yellow projectiles upward from dog's position

---

### Task 3: Create MathBubble Class (30-40 min)
**Goal:** Bubbles with math questions fall from top

**New Class:**
```java
class MathBubble {
   float x, y;
   float speed;
   int num1, num2;      // Numbers in the question
   int answer;          // Correct answer
   boolean active;

   MathBubble() {
      x = random(40, width - 40);
      y = -30;
      speed = random(1, 3);  // Varying speeds

      // Generate simple addition problem
      num1 = int(random(1, 10));
      num2 = int(random(1, 10));
      answer = num1 + num2;
      active = true;
   }

   void move() {
      y += speed;  // Fall downward

      // Deactivate if off bottom of screen
      if (y > height + 30) {
         active = false;
      }
   }

   void display() {
      // Bubble circle
      fill(100, 200, 255, 180);  // Light blue, semi-transparent
      stroke(255);
      strokeWeight(2);
      ellipse(x, y, 60, 60);

      // Question text
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(16);
      text(num1 + "+" + num2, x, y);
      noStroke();
   }

   boolean checkAnswer(int playerAnswer) {
      return playerAnswer == answer;
   }
}
```

**In main sketch:**
```java
ArrayList<MathBubble> bubbles = new ArrayList<MathBubble>();
int frameCounter = 0;

void draw() {
   image(backgroundImg, 0, 0, width, height);

   // Spawn new bubbles every 90 frames (~1.5 seconds at 60fps)
   frameCounter++;
   if (frameCounter > 90) {
      bubbles.add(new MathBubble());
      frameCounter = 0;
   }

   // Update and display bubbles
   for (int i = bubbles.size() - 1; i >= 0; i--) {
      MathBubble b = bubbles.get(i);
      b.move();
      b.display();

      if (!b.active) {
         bubbles.remove(i);
      }
   }

   // Existing projectile and dog code...
}
```

**Learning Focus:**
- Random number generation
- Text rendering in Processing
- Encapsulating game logic in classes
- Frame-based timing

**Test:** Math bubbles (like "3+5") fall from top at varying speeds

---

### Task 4: Collision Detection (25-35 min)
**Goal:** Detect when projectile hits bubble

**Add to draw():**
```java
void draw() {
   // ... existing code ...

   // Check collisions
   for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile p = projectiles.get(i);

      for (int j = bubbles.size() - 1; j >= 0; j--) {
         MathBubble b = bubbles.get(j);

         // Calculate distance between projectile and bubble
         float distance = dist(p.x, p.y, b.x, b.y);

         // If they're touching (bubble radius = 30, projectile radius = 5)
         if (distance < 35) {
            // Collision detected!
            b.active = false;    // Remove bubble
            p.active = false;    // Remove projectile

            // TODO: We'll add scoring logic here next
         }
      }
   }
}
```

**Learning Focus:**
- Distance calculation with `dist()`
- Nested loops for checking all combinations
- Circle collision detection
- When to remove objects

**Test:** Shooting projectiles at bubbles makes them disappear

---

### Task 5: Implement Scoring System (20-30 min)
**Goal:** Track and display score based on correct/incorrect hits

**Problem:** How does player indicate which answer they're choosing?

**Solution Option A - Number Keys:**
Player presses number key before shooting to select their answer

```java
int score = 0;
int currentAnswer = 0;  // Player's selected answer

void keyPressed() {
   // Movement...

   // Number input for answer
   if (key >= '0' && key <= '9') {
      int digit = int(key) - int('0');
      currentAnswer = currentAnswer * 10 + digit;  // Build multi-digit number
   }

   // Shoot with SPACE
   if (key == ' ' && currentAnswer > 0) {
      projectiles.add(new Projectile(myDog.x + 40, myDog.y - 30));
   }

   // Clear answer with BACKSPACE
   if (keyCode == BACKSPACE) {
      currentAnswer = 0;
   }
}
```

**Solution Option B - Labeled Bubbles:**
Each bubble shows its answer, player just hits the correct one

```java
class MathBubble {
   // ... existing code ...

   void display() {
      // Bubble circle
      fill(100, 200, 255, 180);
      stroke(255);
      strokeWeight(2);
      ellipse(x, y, 60, 60);

      // Show the ANSWER instead of question
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(20);
      text(answer, x, y);  // Just show the number
      noStroke();
   }
}
```

Then create bubbles with specific answers player must match to a displayed question.

**Recommended: Option B (simpler for first version)**

**Scoring Logic:**
```java
int score = 0;
int targetAnswer = 0;  // The answer we're looking for
boolean questionActive = false;

void setup() {
   size(400, 400);
   backgroundImg = loadImage("background.png");
   myDog = new Dog(200, height - 60);

   // Start first question
   setNewQuestion();
}

void setNewQuestion() {
   int num1 = int(random(1, 10));
   int num2 = int(random(1, 10));
   targetAnswer = num1 + num2;
   questionActive = true;

   // Display question at top
   // (we'll show this in draw())
}

// In collision detection:
if (distance < 35) {
   if (b.answer == targetAnswer) {
      score += 10;  // Correct!
      setNewQuestion();
   } else {
      score -= 5;   // Wrong answer
   }
   b.active = false;
   p.active = false;
}
```

**Display Score:**
```java
void draw() {
   // ... all existing code ...

   // Score display
   fill(255);
   textAlign(LEFT, TOP);
   textSize(20);
   text("Score: " + score, 10, 10);

   // Current question
   if (questionActive) {
      textAlign(CENTER, TOP);
      textSize(24);
      text("Find: " + targetAnswer, width/2, 10);
   }
}
```

**Learning Focus:**
- Variable state management
- Conditional scoring
- UI text rendering
- Game state tracking

**Test:** Score increases/decreases based on hitting correct/incorrect bubbles

---

### Task 6: Add Game Header & Instructions (15-20 min)
**Goal:** Add header with game explanation and poster connection

**Simple Version - Text Overlay:**
```java
boolean gameStarted = false;

void draw() {
   image(backgroundImg, 0, 0, width, height);

   if (!gameStarted) {
      // Show instructions
      fill(0, 0, 0, 200);  // Semi-transparent black overlay
      rect(0, 0, width, height);

      fill(255);
      textAlign(CENTER, CENTER);
      textSize(24);
      text("MATH BUBBLE SHOOTER", width/2, height/2 - 80);

      textSize(14);
      text("Based on [NGA Poster Name]", width/2, height/2 - 50);
      text("Accession: [Number] | IRN: [Number]", width/2, height/2 - 30);

      textSize(16);
      text("HOW TO PLAY:", width/2, height/2);
      text("← → arrows to move dog", width/2, height/2 + 30);
      text("SPACE to shoot", width/2, height/2 + 50);
      text("Hit bubbles with the answer shown at top", width/2, height/2 + 70);

      textSize(20);
      text("Press SPACE to start", width/2, height/2 + 110);

      return;  // Don't run game yet
   }

   // ... normal game code runs here ...
}

void keyPressed() {
   if (!gameStarted && key == ' ') {
      gameStarted = true;
      return;
   }

   // ... existing game controls ...
}
```

**Advanced Version - Separate Header Area:**
Keep a permanent header at top showing:
- Game title
- Current score
- Current question
- Poster attribution

**Learning Focus:**
- Game states (menu vs playing)
- Multi-line text rendering
- Layout and UI design

**Test:** Game shows instructions before starting, displays poster info

---

## Implementation Session Structure

### Start (10 min)
- Review current dog movement code
- Discuss the game concept
- Show examples of similar games if needed

### Build Core Game Loop (90-120 min)
Work through tasks 1-6 sequentially:
1. Player movement (10 min)
2. Projectile shooting (20-25 min)
3. Math bubbles (30-40 min)
4. Collision detection (25-35 min)
5. Scoring system (20-30 min)
6. Header/instructions (15-20 min)

**Test after each task!**

### Code Review & Testing (15-20 min)
- Play the game together
- Check scoring logic
- Test edge cases (multiple projectiles, rapid firing, etc.)
- Add comments to explain game logic

### Polish (Optional, 15-30 min)
- Adjust bubble spawn rate
- Tweak difficulty (number ranges, speeds)
- Add sound effects (if time)
- Improve visual feedback (bubble pop animation, etc.)

---

## Key Classes Structure

```java
// Main sketch
Dog myDog;
ArrayList<Projectile> projectiles;
ArrayList<MathBubble> bubbles;
PImage backgroundImg;
int score = 0;
int targetAnswer = 0;
boolean gameStarted = false;

// Class 1: Dog (player character)
class Dog {
   float x, y;
   void display() { }
}

// Class 2: Projectile (shot by dog)
class Projectile {
   float x, y, speed;
   boolean active;
   void move() { }
   void display() { }
}

// Class 3: MathBubble (falling targets)
class MathBubble {
   float x, y, speed;
   int num1, num2, answer;
   boolean active;
   void move() { }
   void display() { }
}
```

---

## Assignment Requirements Checklist

After completing today's tasks, we'll have:

- [x] **Variables & arithmetic** - score, positions, math calculations
- [x] **Multiple shapes** - dog (ellipses, triangles, rects), bubbles (circles), projectiles
- [x] **Conditionals** - collision detection, boundary checking, scoring
- [x] **Loops** - iterating through ArrayLists
- [x] **Event handling** - keyboard input (arrows, space, numbers)
- [x] **Custom functions** - setNewQuestion(), collision logic
- [x] **Arrays** - ArrayLists of projectiles and bubbles
- [x] **Self-defined classes** - Dog, Projectile, MathBubble
- [x] **Clean code** - meaningful names, comments
- [x] **Header** - poster attribution and game explanation
- [x] **Game mechanics** - scoring system, falling objects, projectiles

---

## Tomorrow's Goals (Day 3)

Depending on progress:
1. **More question types** - subtraction, multiplication, division
2. **Difficulty levels** - easy/medium/hard with different number ranges
3. **Power-ups** - special bubbles with bonuses
4. **Lives system** - lose lives if bubbles reach bottom
5. **High score** - save and display best score
6. **Sound effects** - shooting, hitting, wrong answer
7. **Particle effects** - bubble pop animation
8. **Better visuals** - connect more closely to NGA poster theme

---

## Parent Guidance Notes

**Design Decisions for Your Son:**
- Which scoring system? (Option A with number input or Option B with labeled bubbles)
- How fast should bubbles fall?
- How many points for correct/incorrect?
- What should the game title be?
- Which NGA poster is this based on? (needs to be decided if not already)

**Common Issues:**
- **Bubbles spawn too fast/slow** - adjust frameCounter threshold
- **Collision not working** - check distance calculation and radii
- **Projectiles shoot too fast** - can add cooldown timer
- **Score goes negative** - can add `score = max(0, score - 5)`

**Questions to Ask:**
- "How could we make the game harder as score increases?"
- "What happens if you don't hit a bubble and it reaches the bottom?"
- "Should there be a time limit?"
- "How does this connect to your chosen poster's theme?"

**Success Criteria:**
- [ ] Dog moves left/right at bottom
- [ ] Projectiles shoot upward when space pressed
- [ ] Math bubbles fall from top with questions/answers
- [ ] Collisions detected correctly
- [ ] Score increases for correct, decreases for wrong
- [ ] Header shows game title and poster info
- [ ] Game is playable and fun!
- [ ] Code is commented and organized
- [ ] Your son can explain the collision detection logic

---

## Notes on ArrayLists vs Arrays

**Why ArrayList?**
- Dynamic size (can add/remove items easily)
- Perfect for projectiles and bubbles that come and go

**Syntax:**
```java
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
projectiles.add(new Projectile(x, y));     // Add
projectiles.get(i);                         // Access
projectiles.remove(i);                      // Remove
projectiles.size();                         // Length
```

**Why iterate backwards when removing?**
```java
// CORRECT - backwards
for (int i = list.size() - 1; i >= 0; i--) {
   if (shouldRemove) list.remove(i);
}

// WRONG - forward (skips elements!)
for (int i = 0; i < list.size(); i++) {
   if (shouldRemove) list.remove(i);  // indices shift!
}
```

This is a key concept for managing dynamic game objects!
