class Ghost extends MovingPiece {
  public Ghost(float r, float c, int velR, int velC) {
    super(r, c, velR, velC);
  }
  public void tick(){
    ai();
    super.tick();
  }
  
  public void ai(){
    
  }
  public void draw() {
    circle(getC()*gridSize+gridSize/2, getR()*gridSize+gridSize/2, gridSize/1.2);
  }
}
