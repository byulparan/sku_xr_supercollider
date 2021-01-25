
class Drop {
  int mX;
  int mY;
  color mColor;
  int mAlpha;
  public Drop(int x, int y) {
    mX = x;
    mY = y;
    mColor = color(random(255), random(255), random(255));
    mAlpha = 255;
  }

  public Drop(color c) {
    mX = int(random(width));
    mY = int (random(height));
    mColor = c;
    mAlpha = 255;
  }

  public void draw() {
    fill(mColor, mAlpha);
    ellipse(mX, mY, 30, 30);
    mX += random(-2, 3);
    mY += 1;
    mAlpha -= 1;
  }
  public boolean isDead() {
    return mAlpha <= 0;
  }
};
