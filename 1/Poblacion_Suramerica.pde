// Ex11_03

//Modificado por: Rodrigo Sánchez

//Este ejemplo lo tomé del tutorial alojado en Lynda y lo modifiqué en varios aspectos para dar una nueva información.
//El objetivo era comparar la población de los países Suramericanos, teniendo en cuenta además las principales ciudades de cada uno.
//Hice modificaciones de la paleta de colores para ser aplicada a la gráfica.
color[] tonos = {#FFDB00, #A0DB00, #000955, #008FD1, #FF3465};
color[] paleta = tonos;
PFont titleFont, labelFont;

Table artData;
int rowCount;
float mx = 29; // mouseX

//Debido al tamaño del gráfico, fue necesario agrandar el canvas.
//Se insertó una tabla con los valores correspondientes a cada ciudad.
//Se crearon nuevas fuentes para el título y los valores a revisar.
void setup() {
  size(600, 400);
  artData = new Table("poblacion.tsv");
  rowCount = artData.getRowCount();
  println("rowCount = " + rowCount);
  titleFont = loadFont("font-titulo.vlw");
  labelFont = loadFont("font-secundaria.vlw");
  smooth();
}

//Se aplicaron nuevos colores de acuerdo a la paleta y se ccoloca el título de acuerdo a color y posición.
//Se crea además una linea "0" para empezar la linea base.
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

  for (int row = 0; row < rowCount; row++) {
    
    // Los datos tienen la posibilidad de visualizarse de acuerdo a las siguientes opciones:
    //El rango de columnas, empezando de 0 a 40 para distribuir en X los datos de cada ciudad y país.
    //Se modificaron los rangos de la columna entre 0 y el mayor número de habitantes (Brasil).
    //Se definió el tamaño de la gráfica.
    String dates = artData.getString(row, 0);
    float popularity = artData.getFloat(row, 1);
    float x = map(row, 0, 40, 30, 575);
    float y = map(popularity, 0, 203000000, 250, 20);
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
    
    // Modificación a las lineas del gráfico, inicio de la linea, color, diametro del círculo.
    stroke(paleta[1]);
    line(x, y, x, 260);
    noStroke();
    fill(paleta[1]);
    int d = 5;
    ellipse(x, y, d, d);
  }
  
  //Se definió la agrupación por países y ciudades en grupos de 4 (1país + 3 ciudades), donde el país se marca más fuerte.
  // Se copiaron las propiedades de las líneas delgadas para mantener valores identicos, modificando únicamente los grosores de línea.
  // se decidió alargar más la linea por temas de pregnancia en la identificación del país.
  for (int row = 0; row < rowCount; row += 4) {
    String dates = artData.getString(row, 0);
    float popularity = artData.getFloat(row, 1);
    float x = map(row, 0, 40, 30, 575);
    float y = map(popularity, 0, 203000000, 250, 20);
    
    //Ubicación de textos inferiores (países)
    text(dates, x, 320);
//    println(dates);
//    noLoop();
      
    //Modificación a las lineas del gráfico (países), inicio de la linea, color, diametro del círculo.
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