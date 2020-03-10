void temperatures()
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
  
  for(int i = 900; i < 405000; i++)
  {
    if(temp[i]>=0)
    {
      temp[i]-=0.4;
    }
    if(temp[i]<0)
    temp[i]=0;
  }
  drawTemperatures();
  winds();
  sunIteration+=direction;
  if(sunIteration > lines.length - 2 || sunIteration < 1)
    direction=-direction;
}

void drawTemperatures()
{
  max = 0;
  for(int i = 0; i < 405000; i++)
  {
    realTemp[i] = map(sin(radians(map(constrain(temp[i],0,240),0,240,0,90))),0,1,0,80);
    if(temp[i] > max)
      max = temp[i];
  }
  for(int i = 0; i < 405000; i++)
  {
    if(temp[i]>0)
    {
      int col = i % 900;
      int row = i / 900;
      color cl = BlackToRed[ceil(map(temp[i],0,max,0,533))];
      fill(cl, 50);
      stroke(cl, 50);
      rect(col,row,1,1);
    }
  }
}
