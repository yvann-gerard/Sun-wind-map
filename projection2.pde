import java.io.FileWriter;
import java.io.FileReader;
import java.util.Date;
import java.io.BufferedWriter;
import org.gicentre.utils.stat.*;
import java.util.Arrays;


String mode = "temperatures"; // "dailyTemperatures" for the inspector window or "temperatures" for the winds and global temperatures


PImage img;

int sunIteration = 0;
int direction = 1;
boolean twoSuns = true;

java.awt.Polygon p = new java.awt.Polygon();
java.awt.Polygon p2 = new java.awt.Polygon();
java.awt.Polygon p3 = new java.awt.Polygon();
String[] lines;
long[][] expositionValues = new long[1800][900];
long[][] expositionValuesTemp = new long[1800][900];
int[] latitudeEquateur;
int[] longitudeEquateur;
int[] map = new int[1620000];

PVector[][] winds = new PVector[150][75];

color target;

color[] cp = {
  color(0, 126, 192), 
  color(24, 154, 208), 
  color(58, 168, 214), 
  color(94, 186, 220), 
  color(128, 199, 228), 
  color(163, 216, 235), 
  color(197, 229, 243), 
  color(232, 244, 250), 
  color(135, 209, 63), 
  color(203, 227, 107), 
  color(255, 227, 153), 
  color(255, 205, 127), 
  color(234, 136, 70), 
  color(209, 104, 47), 
  color(187, 76, 15), 
  color(148, 56, 0)
}; 
color[] BlackToRed = new color[534];

float[] temp = new float[405000];
float[] realTemp = new float[405000];
float max = 1;
float min = 99999;

PWindow win;
public void settings()
{
  size(900, 450); 
}

public void setup() 
{
  frameRate(240);
  surface.setTitle("TERA");
  readColors();
  mapGeneration();
  fill(0,0,0,150);
  resetWinds();
  loadPixels(); 
  lines = loadStrings("coordinates.txt");
  
  latitudeEquateur = new int[lines.length];
  longitudeEquateur = new int[lines.length];
  
  if(mode == "dailyTemperatures")
    win = new PWindow();
}

public void readColors()
{
  img = loadImage("colors.bmp");
  image(img, 0, 0, 534, 1);
  loadPixels();
  for(int i = 0; i < 534; i ++)
  {
  BlackToRed[i] = pixels[i];
  }
}
