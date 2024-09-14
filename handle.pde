class Handle {
  int x, y;
  int boxx, boxy;
  int stretch;
  int size;

  float min;
  float max;

  boolean over;
  boolean press;
  boolean locked = false;
  boolean otherslocked = false;
  int barSize;



  Handle(int ix, int iy, int il, int is, int ibarSize, Handle[] o, float min_, float max_) {
    x = ix;
    y = iy;
    stretch = il;
    size = is;
    boxx = x+stretch - size/2;
    boxy = y - size/2;
    barSize = ibarSize;
    others = o;
    min = min_;
    max = max_;
  }

  Handle[] handles;
  Handle[] others;

  void update() {
    boxx = x + stretch;
    boxy = y - size/2;


    for (int i=0; i<others.length; i++) {
      if (others[i].locked == true) {
        otherslocked = true;
        break;
      } else {
        otherslocked = false;
      }
    }

    if (otherslocked == false) {
      overEvent();
      pressEvent();
    }

    if (press) {
      stretch = lock(mouseX-x-size/2, 0, barSize);
    }
  }

  void overEvent() {
    if (overRect(boxx, boxy, size, size)) {
      over = true;
    } else {
      over = false;
    }
  }

  void pressEvent() {
    if (over && mousePressed || locked) {
      press = true;
      locked = true;
    } else {
      press = false;
    }
  }

  void releaseEvent() {
    locked = false;
  }

  void display() {
    strokeWeight(5);
    stroke(0);
    line(x, y, x+barSize, y);
    stroke(255, 0, 0);
    line(x, y, x+stretch, y);
    fill(255);
    strokeWeight(2);
    stroke(0);
    rect(boxx, boxy, size, size);
    if (over || press) {
      line(boxx, boxy, boxx+size, boxy+size);
      line(boxx, boxy+size, boxx+size, boxy);
    }
    fill(0);
    strokeWeight(5);
    textSize(20);
    textAlign(CORNER);
    float val = map(stretch, 0, barSize, min, max);
    String valf = nf(val, 0, 2);
    text(valf, x+barSize+size, y);
  }

  float val() {
    float val = map(stretch, 0, barSize, min, max);
    return val;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    noCursor();
    return true;
  } else {
    cursor();
    return false;
  }
}

int lock(int val, int minv, int maxv) {
  return  min(max(val, minv), maxv);
}

void mouseReleased() {
  for (int i = 0; i < handles.length; i++) {
    handles[i].releaseEvent();
  }
}
