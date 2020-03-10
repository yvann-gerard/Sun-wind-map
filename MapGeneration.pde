void mapGeneration()
{
  noiseSeed(int(random(10000000))); 
  loadPixels(); 
  float d0 = random(100, 200);   
  float d1 = random(25, 75); 
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      float n0 = noise(i/d0, j/d0, 0); 
      float n1 = noise(i/d1, j/d1, 10); 
      float n = 1 - (n0*0.75 + n1*0.25); 
      int k = int(n*cp.length); 
      pixels[j*width + i] = cp[k];
    }
  } 
  map = pixels;
  updatePixels();
}