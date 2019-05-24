class PacMan extends MovingPiece {
  public PacMan() {
    super(22, 12.5, 0, 1);
  }

  public void tick() {
    super.tick();
    eat();
  }
  
  public void draw() {
    circle(getC()*gridSize+gridSize/2, getR()*gridSize+gridSize/2, gridSize/1.2);
  }
  private void eat() {
    if ((int)getR()==getR() && (int)getC()==getC()) {
      board[(int)getR()][(int)getC()] = 3;
    }
  }
}
