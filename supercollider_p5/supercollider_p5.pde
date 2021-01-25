import java.util.ArrayList;
import oscP5.*;

ArrayList<Drop> list;
OscP5 osc;
float h;
float sz;

void setup() {
  size(800, 600);
  h = 0.0;
  osc = new OscP5(this, 12000);
  sz = 30.0;
  list = new ArrayList<Drop>();
}

void draw() {
  fill(0, 3);
  rect(0, 0, width, height);
  ArrayList<Drop> temp = new ArrayList<Drop>();
  synchronized(list) {
    for (Drop b : list) {
      b.draw(); 
      if (b.isDead()) {
        temp.add(b);
      }
    }
    for (Drop b : temp) {
      list.remove(b);
    }
  }

  fill(255, 0, 0);
  ellipse(width*0.5, height*0.5 - h, sz, sz);
}

void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();
  synchronized(list) {
    if (addr.equals("/drop")) {
      list.add(new Drop(int(random(width)), int(random(height))));
    } else if (addr.equals("/circle")) {
      h = msg.get(0).floatValue();
      sz = msg.get(1).floatValue();
    }
  }
}
