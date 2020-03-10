class PWindow extends PApplet {
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  XYChart lineChart;
  float[] hours = new float[241];
  float[] lighted = new float[241];
  int lightedCount = 0;
  float[] temperatues = new float[241];
  int brightness;
  
  int[] vals = new int[241];
  
  void settings() 
  {
    size(500, 400);
  }

  void setup() 
  {

    for(int i = 0; i < 241; i++)
      hours[i]=i;
    
    c1 = color(0, 0, 255);
    c2 = color(255, 0, 0);
    
    lineChart = new XYChart(this);

                      
    // Axis formatting and labels.
    lineChart.showXAxis(true); 
    lineChart.showYAxis(true); 
       
    lineChart.setMaxY(80);  
    lineChart.setMinY(0);  
       
    lineChart.setYFormat("####°C");  
    lineChart.setXFormat("00.0");      
     
    // Symbol colours
    lineChart.setPointColour(color(180,50,50,100));
    lineChart.setPointSize(0);
    lineChart.setLineWidth(2);
    lineChart.setAxisColour(255);
    lineChart.setAxisValuesColour(255);
  }
  
 
  
  void draw() 
  {
    background(0);
    
    if(mode == "nothing")
    {
      fill(255);
      if(red(target) == blue(target))
        brightnessPicker();
      else
        text("This area is never lighted by the stars",200,390);
      colorPicker();
      chartsPicker();
    }
    else
    {
      text("Loading, please wait for a complete cycle ...",130,200);
    }
  }

  color c1, c2;

  void colorPicker()
  {
    noStroke();
    fill(255);
    text(red(target),250,350);
    fill(red(target));
    rect(220,340,10,10);
  }

  void brightnessPicker()
  {
    stroke(255);
    fill(0);
    rect(10,9,40,302);
    noStroke();
    
    fill(255);
    brightness = round(map(red(target),0,255,10,160));
    setGradient(11, 160, 38, 160-brightness, c2, c1);
    setGradient(11, brightness, 38, 160-brightness, c1, c2);
    text("0",55,15);
    text("6",55,90);
    text("12",55,165);
    text("18",55,240);
    text("24",55,315);
    
    stroke(255,0,0);
    line(10,160,50,160);
    
    stroke(255,255,0);
    if(brightness<160)
    {
      line(35,(brightness+160)/2,75,(brightness+160)/2);
      text(map(brightness,10,160,6,12), 77, (brightness+160)/2);
      line(35,320-((brightness+160)/2),75,320-((brightness+160)/2));
      text(24-map(brightness,10,160,6,12), 77, 320-((brightness+160)/2));
    }
    
    text((12-map(brightness,10,160,6,12))*4,15,350);
  }

  void chartsPicker()
  {  
    lineChart.setData(hours,lighted);
                      
    lineChart.setLineColour(color(255,0,0));
    lineChart.draw(125,15,width-140,height-90);
    
    temperatues = temperaturesCalc(temperatues);
    lineChart.setData(hours, temperatues);
                      
    lineChart.setLineColour(255);
    lineChart.draw(125,15,width-140,height-90);
  }


  void setGradient(int x, int y, float w, float h, color c1, color c2) 
  {
    noFill();
  
    for (int i = y; i <= y+h; i++) 
    {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
  
  float[] temperaturesCalc(float[] realTemp)
  {    
    float offset = 0;
    
    for(int i = 0; i < 241; i++)
    {
      if(i >= map(brightness,10,160,0,120) && i <= 240-map(brightness,10,160,0,120))
      {
        lighted[i]=80;
        lightedCount++;
        if(i>0)
        {
          if(lighted[i-1]==0)
          {
            offset=map(degrees(asin(map(realTemp[i-1],0,80,0,1))),0,90,0,240);
          }
          realTemp[i]=map(sin(radians(map(constrain(lightedCount+offset,0,240),0,240,0,90))),0,1,0,80);
        }
      }
      else
      {
        lightedCount=0;
        lighted[i]=0;
        if(i>0)
          realTemp[i]=realTemp[i-1]-0.8;
        else
          realTemp[i]=realTemp[240]-0.8;
      }
      if(realTemp[i]<0)
      realTemp[i]=0;
    }
    if(realTemp[240]>0)
    {
      boolean done = true;
      for(int i = 0; i < 241; i++)
      {
        if(vals[i] != round(realTemp[i]))
        {
          vals[i] = round(realTemp[i]);
          done = false;
        }
      }
      if(!done)
      {
        realTemp = temperaturesCalc(realTemp);
      }
    }
    return realTemp;
  }
  
}
