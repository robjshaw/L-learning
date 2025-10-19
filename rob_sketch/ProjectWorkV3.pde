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
    //no x speed
    y -= speed;

    // off the top will get rid projectile
    if (y < 0) {
      active = false;
    }
  }

  // different display since its a different class
  void display () {
    fill(255, 255, 0);
    ellipse (x, y, 10, 10);
  }
}


class Dog {
  float x, y;
  float speedX, speedY;
  //float diameter;

  // Constructor
  Dog(float startX, float startY) {

    x = startX;
    y = startY;
    speedX = 3;
    speedY = 2;
  }




  void display() {
    // ---------------------DOG --------------
    //body

    fill(255, 50, 50);
    ellipse(x, y, 80, 50);

    //head
    fill(255, 50, 50);
    ellipse (x + 40, y -10, 40, 40);

    //ear only 1
    fill (255, 50, 50);
    triangle(x + 25, y - 25, x + 30, y - 5, x + 35, y - 25);

    //nose
    fill (255, 50, 50);
    ellipse(x + 55, y - 5, 15, 12);

    //nostril
    fill (255, 50, 50);
    ellipse(x + 60, y - 5, 6, 5);

    //eye
    fill (0, 0, 0);
    ellipse(x + 45, y - 15, 5, 5);

    //legs left to right
    fill (255, 50, 50);
    rect(x - 20, y + 15, 8, 25);
    rect(x - 5, y + 15, 8, 25);
    rect(x + 10, y + 15, 8, 25);
    rect(x + 25, y + 15, 8, 25);

    //tail (make bigger)
    fill (255, 50, 50);
    triangle (x-40, y - 10, x - 35, y, x - 30, y - 5);
  }
}


class MathBubble {
  float x, y;
  float speed;
  int no1, no2;
  int answer;
  boolean active;

  MathBubble() {
    x = random (40, width - 40);
    y = -30;
    //random speeds
    speed = random(1, 3);

    //random equations
    no1 = int (random(1, 10));
    no2 = int (random(1, 10));
    answer = no1 + no2;
    active = true;
  }

  void move () {
    //+ because its going down (larger number)
    y+= speed;
    if (y > height + 30) {
      active = false;
    }
  }

  // --------maths display
  void display() {

    //bubble
    fill(100, 200, 255, 180);
    stroke(255);
    strokeWeight(2);
    ellipse(x, y, 60, 60);

      //text
    //fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(no1 + "+" + no2, x, y);
    //noStroke();
  
  }
  
  boolean checkAnswer(int playerAnswer) {
    return playerAnswer == answer;
  }
}





// In main sketch:
Dog myDog;
PImage backgroundImg;

void setup() {
  size(1000, 1000);
  backgroundImg = loadImage ("background.png");
  // where it starts, where x and y are based off
  myDog = new Dog (100, 800);
}

ArrayList<MathBubble> bubbles = new ArrayList<MathBubble>();
int frameCounter = 0;

void draw() {
  background(0);
  // 0, 0 is where is starts
  image (backgroundImg, 0, 0, width, height);

  // frame counter
  frameCounter++;
  if (frameCounter > 90) {
    bubbles.add(new MathBubble());
    frameCounter = 0;
  }
  for (int i = bubbles.size() - 1; i >=0; i--) {
    MathBubble b = bubbles.get(i);
    b.move();
    b.display();

    if (!b.active) {
      bubbles.remove(i);
    }
  }

  myDog.display();

  // i is the count of the array items
  for (int i = projectiles.size() - 1; i >=0; i--) {
    Projectile p = projectiles.get(i);
    p.move();
    p.display();

    //remove the projectile
    if (!p.active) {
      projectiles.remove(i);
    }
  }
}
//array
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

void keyPressed() {
  if (keyCode == LEFT) {
    myDog.x -= 10;
    if (myDog.x < 60) {
      myDog.x = 60;
    }
  }
  // - 80 since x comes from centre
  if (keyCode == RIGHT) {
    myDog.x += 10;
    if (myDog.x > width - 80) {
      myDog.x = width - 80;
    }
  }
  // projectile
  if (key == ' ') {
    projectiles.add(new Projectile(myDog.x + 40, myDog.y -30));
  }
}
