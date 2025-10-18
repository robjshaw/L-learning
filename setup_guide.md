# Processing Setup Guide - Mac & Windows (VS Code)

## Option 1: Processing IDE (Recommended for Beginners)

### Mac Setup (You)
1. Download Processing from https://processing.org/download
2. Extract the downloaded `.zip` file
3. Drag `Processing.app` to your Applications folder
4. Open Processing from Applications
5. Test: File → Examples → Basics → Shape → Bezier (run the sketch)

### Windows Setup (Your Son)
1. Download Processing from https://processing.org/download
2. Extract the downloaded `.zip` file to `C:\Program Files\Processing` (or desired location)
3. Run `processing.exe` from the extracted folder
4. Create desktop shortcut if desired
5. Test: File → Examples → Basics → Shape → Bezier (run the sketch)

**Pros:** Simple, built-in, everything included
**Cons:** Less familiar if you prefer VS Code

---

## Option 2: VS Code with Processing (For Familiar Environment)

### Mac Setup (You)

**Step 1: Install Processing Core**
1. Download Processing from https://processing.org/download
2. Extract and place in Applications folder (needed for the language/compiler)

**Step 2: Install VS Code Extension**
1. Open VS Code
2. Go to Extensions (Cmd+Shift+X)
3. Search for "Processing Language"
4. Install the extension by Tobias Bradtke

**Step 3: Configure Processing Path**
1. Open VS Code Settings (Cmd+,)
2. Search for "processing.path"
3. Set path to: `/Applications/Processing.app/Contents/MacOS/processing-java`

**Step 4: Create Test Sketch**
1. Create new folder: `mkdir ~/ProcessingProjects/test_sketch`
2. Create file: `test_sketch.pde` in that folder
3. Add this code:
```java
void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  ellipse(mouseX, mouseY, 50, 50);
}
```
4. Run with Cmd+Shift+P → "Processing: Run Processing Project"

---

### Windows Setup (Your Son)

**Step 1: Install Processing Core**
1. Download Processing from https://processing.org/download
2. Extract to `C:\Program Files\Processing`

**Step 2: Install VS Code Extension**
1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Processing Language"
4. Install the extension by Tobias Bradtke

**Step 3: Configure Processing Path**
1. Open VS Code Settings (Ctrl+,)
2. Search for "processing.path"
3. Set path to: `C:\Program Files\Processing\processing-java.exe`
   (Adjust if you installed to a different location)

**Step 4: Create Test Sketch**
1. Create new folder: `C:\Users\[Username]\ProcessingProjects\test_sketch`
2. Create file: `test_sketch.pde` in that folder
3. Add this code:
```java
void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  ellipse(mouseX, mouseY, 50, 50);
}
```
4. Run with Ctrl+Shift+P → "Processing: Run Processing Project"

---

## Important Notes

**File Structure:**
- Each Processing sketch needs its own folder
- The `.pde` file must have the same name as the folder
- Example: `my_sketch/my_sketch.pde` ✓
- Example: `my_sketch/animation.pde` ✗ (won't work)

**Which Option Should You Choose?**

**Processing IDE** if:
- Your son wants simplest setup
- You want instant gratification (runs immediately)
- You don't mind learning a new editor

**VS Code** if:
- You want to use familiar tools
- You want better IntelliSense/autocomplete
- You plan to work in both environments

**My Recommendation:** Start with Processing IDE for the first few days, then optionally switch to VS Code once he's comfortable with the basics. The IDE is designed for learning and has better built-in examples.

---

## Troubleshooting

**VS Code: "Cannot find processing-java"**
- Verify the path in settings matches your actual installation
- Mac: Use `which processing-java` in Terminal if installed via Homebrew
- Windows: Check `C:\Program Files\Processing\processing-java.exe` exists

**Sketch won't run**
- Verify folder name matches .pde filename exactly
- Make sure you have both `setup()` and `draw()` functions
- Check for syntax errors (missing semicolons, braces)

**Mac: "Processing.app can't be opened because it is from an unidentified developer"**
- Right-click Processing.app → Open → Open anyway
- Or: System Preferences → Security & Privacy → Allow
