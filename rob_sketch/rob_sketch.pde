class Ball {
  // Data (instance variables)
  float x, y;
  float speedX, speedY;
  float diameter;
  
  // Constructor (initializes object)
  Ball(float startX, float startY) {
    x = startX;
    y = startY;
    speedX = 5;
    speedY = 3;
    diameter = 60;
  }
  
  // Methods (functionality)
  void move() {
    x += speedX;
    y += speedY;
    
    if (x > width || x < 0) {
      speedX *= -1;
    }
    if (y > height || y < 0) {
      speedY *= -1;
    }
  }
  
  void display() {
    fill(255, 0, 0);
    ellipse(x, y, diameter, diameter);
  }
}

// In main sketch:
Ball myBall;

void setup() {
  size(400, 400);
  myBall = new Ball(100, 100);
}

void draw() {
  background(0);
  myBall.move();
  myBall.display();
}
