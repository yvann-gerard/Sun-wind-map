void winds()
{

  resetWinds();
  for(int col = 0; col < 150; col++)
    for(int row = 0; row < 75; row++)
    {
      float x = 0;
      float y = 0;
      for(int i = 1; i < 3; i++)
      {
        for(int j = -2; j < 3; j++)
        { 
          x += temp[(col*6+3)+((row*6+3)*900-i)-j*900] - temp[(col*6+3)+(row*6+3)*900];
          x -= temp[(col*6+3)+((row*6+3)*900+i)+j*900] - temp[(col*6+3)+(row*6+3)*900];
          y += temp[(col*6+3)+((row*6+3)*900+j)-i*900] - temp[(col*6+3)+(row*6+3)*900];
          y -= temp[(col*6+3)+((row*6+3)*900-j)+i*900] - temp[(col*6+3)+(row*6+3)*900]; 
        }
      }
      PVector diff = new PVector(x, y);
      diff.normalize();
      diff.mult(map(temp[(col*6+3)+(row*6+3)*900],0,max,0,5.5)+2);
      
      winds[col][row].add(diff);
      drawArrow(col*6+3, row*6+3, col*6+3 + winds[col][row].x, row*6+3 + winds[col][row].y);
    }
}

void resetWinds()
{
  for(int col = 0; col < 150; col++)
    for(int row = 0; row < 75; row++)
      winds[col][row] = new PVector(0,0);
}


void drawArrow(float x1, float y1, float x2, float y2) 
{
  float a = dist(x1, y1, x2, y2) / 50;
  pushMatrix();
  translate(x2, y2);
  rotate(atan2(y2 - y1, x2 - x1));
  stroke(255,0,0);
  triangle(- a * 5 , - a, 0, 0, - a * 5, a);
  popMatrix();
  stroke(0);
  line(x1, y1, x2, y2);  
}
