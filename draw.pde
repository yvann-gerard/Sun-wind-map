
void draw()
{
  target = get(mouseX,mouseY);
    
  if(mode != "nothing")
  { 
    updatePixels();
 
    String[] pieces = split(lines[sunIteration], ';');
    p.reset();
    p2.reset();
    p3.reset();
    
    fill(0,0,0,0);
    stroke(0,0,0,255);
    
    beginShape();
    for(int j = 1; j < pieces.length-2; j+=2)
    {
      int pointX = int(pieces[j]);
      int pointY = -int(pieces[j+1]);
      if (direction < 0)
        pointX = 1800-pointX;
      p.addPoint(pointX/2, pointY/2);
      vertex(pointX/2, pointY/2);
    }
    endShape();
    
    if(twoSuns)
    {
      pieces = split(lines[lines.length -1 - sunIteration], ';');
  
      beginShape();
      for(int j = 1; j < pieces.length-2; j+=2)
      {
        int pointX = int(pieces[j])-900;
        int pointY = -int(pieces[j+1]);
        if (direction < 0)
          pointX = 1800-pointX;
        p2.addPoint(pointX/2, pointY/2);
        vertex(pointX/2, pointY/2);
      }
      endShape();
      
      beginShape();
      for(int j = 1; j < pieces.length-2; j+=2)
      {
        int pointX = int(pieces[j])+900;
        int pointY = -int(pieces[j+1]);
        if (direction < 0)
          pointX = 1800-pointX;
        p3.addPoint(pointX/2, pointY/2);
        vertex(pointX/2, pointY/2);
      }
      endShape();
    }
    
    longitudeEquateur[sunIteration] = int(pieces[pieces.length-2]);
    latitudeEquateur[sunIteration] = -int(pieces[pieces.length-1]);
    
    if(mode == "dailyTemperatures")
      dailyTemperatures();
    if(mode == "temperatures")
      temperatures();
   }
}
