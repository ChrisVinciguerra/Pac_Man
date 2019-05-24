abstract class MovingPiece {
  private float r, c;
  private float velR, velC;
  private float nextVelR, nextVelC;

  public MovingPiece(float r, float c, float velR, float velC) {
    this.r = r;
    this.c = c;
    this.velR = velR;
    this.velC = velC;
    nextVelR = velR;
    nextVelC = velC;
  }

  public float getR() {
    return r;
  }

  public float getC() {
    return c;
  }

  public void queueTurn(float velR, float velC) {
    nextVelR = velR;
    nextVelC = velC;
  }

  public void move() {
    //Decide whether it is time to change direction
    float testR = r+nextVelR;
    float testC = c+nextVelC;
    if (nextVelR>0 && (int)c==c) {
      if (isInBounds((int)Math.ceil(testR), (int)c) && board[(int)Math.ceil(testR)][(int)c] != 0) {
        velR = nextVelR;
        velC=0;
      }
    } else if (nextVelR<0 && (int)c==c) {
      if (isInBounds((int)Math.floor(testR), (int)c) && board[(int)Math.floor(testR)][(int)c] != 0) {
        velR = nextVelR;
        velC=0;
      }
    }
    if (nextVelC>0 && (int) r == r) {
      if (isInBounds((int)r, (int)Math.ceil(testC)) && board[(int)r][(int)Math.ceil(testC)] != 0) {
        velC = nextVelC;
        velR=0;
      }
    } else if (nextVelC<0 && (int) r ==r) {
      if (isInBounds((int)r, (int)Math.floor(testC)) && board[(int)r][(int)Math.floor(testC)] != 0) {
        velC = nextVelC;
        velR=0;
      }
    }

    //Actually move piece
    testR = r+velR;
    testC = c+velC;
    if (velR>0) {
      if (isInBounds((int)Math.ceil(testR), (int)c) && board[(int)Math.ceil(testR)][(int)c] != 0) {
        r += .1;
        r = (int)(Math.round(r*10))/10.0;
      }
    } else if (velR<0) {
      if (isInBounds((int)Math.floor(testR), (int)c) && board[(int)Math.floor(testR)][(int)c] != 0) {
        r -= .1;
        r = (int)(Math.round(r*10))/10.0;
      }
    }
    if (velC>0) {
      if (isInBounds((int)r, (int)Math.ceil(testC)) && board[(int)r][(int)Math.ceil(testC)] != 0) {
        c += .1;
        c = (int)(Math.round(c*10))/10.0;
      }
    } else if (velC<0) {
      if (isInBounds((int)r, (int)Math.floor(testC)) && board[(int)r][(int)Math.floor(testC)] != 0) {
        c -= .1;
        c = (int)(Math.round(c*10))/10.0;
      }
    }
  }

  public boolean isInBounds(int testR, int testC) {
    return !(testR<0||testC<0||testR>28||testC>25);
  }
  public abstract void draw();
}
