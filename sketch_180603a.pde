import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
 
import ddf.minim.*;
 
Minim minim;
AudioPlayer song;
 
int t;
int n;
boolean beat = false;
 
//Parâmetros que você pode mudar
String arquivo = "música.mp3"; //Escolher o arquivo
int tempo = 90; //Linha nova da baseline a cada 120 frames, (original = 120 frame = 2 segundos)
int fr = 30; //Framerate, quanto menor, mais vezes ele vai desenhar na mesma linha da baseline, aumentar caso ache que ficou muito poluído (original = 10);
int step = 60; //Pular x pixels a cada linha nova (original = 30);
int amp = 280; //Altera tb, de 20 a 300 (original = 120);
int alpha = 160; //Opacidade das linhas, de 0 a 255 (original = 140);
float weight = 1; //Stroke Weight (entre 0 e 3?)
 
int vol;
 
void setup() {
  //1440x1024 //Metade
  //2880, 2048 //Original
  //3461 x 2478 //Alta
  size(3461, 2478);
  minim = new Minim(this);
  song = minim.loadFile(arquivo, width);
  song.play();
 
  background(255);
  strokeWeight(0.5);
  noFill();
}
 
void draw() {
  t = frameCount;
  println(t);
 
  if (t % tempo == 0) {
    beat = true;
    n+=step;
  } else {
    beat = false;
  }
 
  if (t % fr == 0) {
    beat = true;
  } else {
    beat = false;
  }
 
  stroke(0, 0, 0, alpha);
  beginShape();
  for (int i = 0; i < song.bufferSize() - 1; i++) {
    if (beat == true) {
      float z = map(i, 0, song.bufferSize(), 0, width);
      vertex(z, 0 + song.mix.get(i)*amp + n);
      vertex(z+1, 0 + song.left.get(i+1)*amp + n);
      //line(z, 0 + song.mix.get(i)*amp + n, z+1, 0 + song.left.get(i+1)*amp + n);
    }
  }
  endShape();
}
 
void keyPressed() {
  if (key == 's') {
    saveFrame("print/print-####.tiff");
  }
}
