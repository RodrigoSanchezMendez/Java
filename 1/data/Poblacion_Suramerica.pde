// Ex11_03
//modificación de la paleta
color[] tonos = {#FFDB00, #A0DB00, #000955, #008FD1, #FF3465};
color[] paleta = tonos;
PFont titleFont, labelFont;

Table artData;
int rowCount;
float mx = 29; // mouseX

//canvas
void setup() {
  size(600, 400);
  artData = new Table("braque.tsv");
  rowCount = artData.getRowCount();
  println("rowCount = " + rowCount);
  titleFont = loadFont("font-titulo.vlw");
  labelFont = loadFont("font-secundaria.vlw");
  smooth();
}

//colores de acuerdo a la paleta y titulo
void draw() {
  noCursor();
  background(paleta[2]);
  textFont(titleFont);
  stroke(paleta[3]);
  strokeWeight(1);
  fill(paleta[3]);
  textAlign(CENTER);
  text("Ciudades más pobladas por país en Suramérica", width/2, 380);
  line(20,260,580,260);
  stroke(paleta[4]);
  
  textFont(labelFont);
  textAlign(LEFT);

  // Read popularity
  for (int row = 0; row < rowCount; row++) {
    
    // Braque's popularity data
    String dates = artData.getString(row, 0);
    float popularity = artData.getFloat(row, 1);
    float x = map(row, 0, 41, 30, 575);
    float y = map(popularity, 90000, 210000000, 250, 20);
//    println(nfp(popularity, 1, 3) + " : " + nf(y, 3, 2));
//    noLoop();
    
    // Slicing interaction for dates and values
    // Placed here so it goes behind the data lines
    strokeWeight(2);
//    strokeWeight(5);
    if((mx > 30) && (mx < 575)) {
      line(mx, 300, mx, 30);
      if(abs(mx - x) < 2) {
        fill(paleta[0]);
        text(dates, mx + 6, 40);
        text(nfp(popularity, 1, 0), mx + 6, 55);
      }
    }  
    
    // inicio de la linea
    stroke(paleta[1]);
    line(x, y, x, 260);
    noStroke();
    fill(paleta[1]);
    int d = 5;
    ellipse(x, y, d, d);
  }
  
  // secuencia cada 4
  for (int row = 0; row < rowCount; row += 4) {
    String dates = artData.getString(row, 0);
    float popularity = artData.getFloat(row, 1);
    float x = map(row, 0, 41, 30, 575);
    float y = map(popularity, 90000, 210000000, 250, 20);
    
    // textos inferiores
    text(dates, x, 320);
//    println(dates);
//    noLoop();
      
    // lineas principales
    stroke(paleta[1]);
    strokeWeight(3);
    strokeCap(SQUARE);
    line(x, y, x, 300);
    noStroke();
    
  }
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == LEFT) {
      mx -= 2;
    } else if (keyCode == RIGHT) {
      mx += 2;
    }
  }
}

void mouseMoved() {
  mx = mouseX;
}