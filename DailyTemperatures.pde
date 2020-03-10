void dailyTemperatures()
{
  calculateDailyTemperatures();
  sunIteration+=direction;
  if(sunIteration > lines.length - 2)
    direction=-direction;
  if(sunIteration < 1)
    drawDailyTemperatures();
}

void calculateDailyTemperatures()
{
  for(int col = (int)p.getBounds().getMinX(); col < (int)p.getBounds().getMaxX(); col++)
  {
    for(int row = (int)p.getBounds().getMinY(); row < (int)p.getBounds().getMaxY(); row++)
    {
      if(col > 0 && row > 0 && col < 900 && row < 450 && p.contains(col,row))
      {
        temp[row*900+col]++;
      }
    }
  }
  
  for(int col = (int)p2.getBounds().getMinX(); col < (int)p2.getBounds().getMaxX(); col++)
  {
    for(int row = (int)p2.getBounds().getMinY(); row < (int)p2.getBounds().getMaxY(); row++)
    {
      if(col > 0 && row > 0 && col < 900 && row < 450 && p2.contains(col,row))
      {
        temp[row*900+col]++;
      }
    }
  }
  
  for(int col = (int)p3.getBounds().getMinX(); col < (int)p3.getBounds().getMaxX(); col++)
  {
    for(int row = (int)p3.getBounds().getMinY(); row < (int)p3.getBounds().getMaxY(); row++)
    {
      if(col > 0 && row > 0 && col < 900 && row < 450 && p3.contains(col,row))
      {
        temp[row*900+col]++;
      }
    }
  }
}

void drawDailyTemperatures()
{
  mode = "nothing";
  max = 0;
  for(int i = 0; i < 405000; i++)
  {
    if(temp[i] > max)
      max = temp[i];
  }
  
  for(int i = 0; i < 405000; i++)
  {
    if(temp[i]>0)
    {
      int col = i % 900;
      int row = i / 900;
      color cl = color(255-ceil(map(temp[i],0,max,0,255)));
      fill(cl);
      stroke(cl);
      rect(col,row,1,1);
    }
  }
}
