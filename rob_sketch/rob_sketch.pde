class Dog {
  // Data (instance variables)
  float x, y;
  float speedX, speedY;

  // Constructor (initializes object)
  Dog(float startX, float startY) {
    x = startX;
    y = startY;
    speedX = 3;
    speedY = 2;
  }

  // Methods (functionality)
  void move() {
    // x += speedX;
    // y += speedY;

    // Bounce off edges (accounting for dog size - body is about 80 wide, 60 tall)
    if (x > width - 40 || x < 40) {
      speedX *= -1;
    }
    if (y > height - 30 || y < 30) {
      speedY *= -1;
    }
  }

  void display() {
    // Body (ellipse)
    fill(200, 100, 50);  // Brown color
    ellipse(x, y, 80, 50);

    // Head (ellipse)
    fill(200, 100, 50);
    ellipse(x + 40, y - 10, 40, 40);

    // Ears (triangles)
    fill(180, 90, 40);
    triangle(x + 25, y - 25, x + 30, y - 5, x + 35, y - 25);  // Left ear
    triangle(x + 45, y - 25, x + 50, y - 5, x + 55, y - 25);  // Right ear

    // Snout (small ellipse)
    fill(150, 80, 30);
    ellipse(x + 55, y - 5, 15, 12);

    // Nose (small ellipse)
    fill(50);
    ellipse(x + 60, y - 5, 6, 5);

    // Eye (small circle)
    fill(50);
    ellipse(x + 45, y - 15, 5, 5);

    // Legs (rectangles)
    fill(180, 90, 40);
    rect(x - 20, y + 15, 8, 25);  // Front left leg
    rect(x - 5, y + 15, 8, 25);   // Front right leg
    rect(x + 10, y + 15, 8, 25);  // Back left leg
    rect(x + 25, y + 15, 8, 25);  // Back right leg

    // Tail (triangle)
    fill(180, 90, 40);
    triangle(x - 40, y - 10, x - 35, y, x - 30, y - 5);
  }
}

// In main sketch:
Dog myDog;
PImage backgroundImg;

void setup() {
  size(400, 400);
  backgroundImg = loadImage("background.png");
  myDog = new Dog(100, 100);
}

void draw() {
  image(backgroundImg, 0, 0, width, height);  // Display background image
  myDog.move();
  myDog.display();
}

void keyPressed() {
   if (keyCode == LEFT) {
      myDog.x -= 5;  // Move left
   }
   if (keyCode == RIGHT) {
      myDog.x += 5;  // Move right
   }
}
