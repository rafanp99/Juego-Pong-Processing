int anchoLienzo = 800;
int altoLienzo = 600;
int altPlayer = 20;
int anchoPlayer = anchoLienzo/8;
int tamPelota = 20;
int redAlto = 60;
int redAncho = 14;
int p1Score=0;
int p2Score=0;
float velocidadPlayers=20;
float fuerzaRebotePala = 1.6;
int player1AntX=0;
int player2AntX=0;
int player1X=anchoLienzo/2/2-redAncho/2-(anchoPlayer/2);
int player2X=anchoLienzo/2/2*3-redAncho/2-(anchoPlayer/2);
float pelotaX;
float pelotaY;
float pelotaAceleracionY;
float pelotaAceleracionX;
float gravedad=1.5;
int ultimoToque=0;
ArrayList<String> keysMantenidas = new ArrayList<String>();
void iniciarBola(){
  pelotaAceleracionY=-30;
  pelotaY=altoLienzo-(redAlto+30)-tamPelota/2;
  float dirBola=random(-10,10);
  while(dirBola>-5 && dirBola<5){
    dirBola=random(-10,10);
  }
  if(dirBola<0){
    ultimoToque = -1;
  }else{
    ultimoToque = +1;
  }
  pelotaAceleracionX=dirBola;
  pelotaX=anchoLienzo/2-tamPelota/2;
}
void setup(){
  size(800,600);
  frameRate(30);
  iniciarBola();
}
boolean checkKey(String tecla){
  for(int i=0;i<keysMantenidas.size();i++){
    if(keysMantenidas.get(i).equals(tecla)){
      return true;
    }
  }
  return false;
}
void addKeyHolding(char tecla){
  if(checkKey(""+tecla)){
    return;
  }
  keysMantenidas.add(""+tecla);
}
void delKeyHolding(char tecla){
  for(int i=0;i<keysMantenidas.size();i++){
    if(tecla=='a' || tecla=='d' || tecla=='j' || tecla=='l'){
      player1AntX=player1X;
      player2AntX=player2X;
    }
    if(keysMantenidas.get(i).equals(""+tecla)){
      keysMantenidas.remove(i);
    }
  }
}
void playTeclas(){
  for(int i=0;i<keysMantenidas.size();i++){
    switch(keysMantenidas.get(i)){
      case "a":
        println("Es la a");
        if(player1X>0){
          player1AntX=player1X;
          player1X-=velocidadPlayers;
        }
        break;
      case "d":
        if(player1X<( (anchoLienzo/2-redAncho/2) - anchoPlayer ) ){
          player1AntX=player1X;
          player1X+=velocidadPlayers;
        }
        println("Es la d");
        break;
      case "j":
        println("Es la j");
        if(player2X > (anchoLienzo/2+redAncho/2)){
          player2AntX=player2X;
          player2X-=velocidadPlayers;
        }
        break;
      case "l":
        if(player2X<( anchoLienzo - anchoPlayer ) ){
          player2AntX=player2X;
          player2X+=velocidadPlayers;
        }
        println("Es la l");
        break;
  }
  }
}
void keyReleased(){
  switch(key){
    case 'a':
      delKeyHolding(key);
      break;
    case 'd':
      delKeyHolding(key);
      break;
    case 'j':
      delKeyHolding(key);
      break;
    case 'l':
      delKeyHolding(key);
      break;
  }
}
void keyPressed(){
  switch(key){
    case 'a':
      addKeyHolding(key);
      break;
    case 'd':
      addKeyHolding(key);
      break;
    case 'j':
      addKeyHolding(key);
      break;
    case 'l':
      addKeyHolding(key);
      break;
  }
}
void addScore(int playerN){
  if(playerN < 0){
    p2Score++;
  } else {
    p1Score++;
  }
  iniciarBola();
}
void draw(){
  playTeclas();
  background(0);
  noStroke();
  fill(255);
  text(p1Score+" - "+p2Score,anchoLienzo/2-20,30);
  rect(player1X,altoLienzo-altPlayer,anchoPlayer,altPlayer);
  rect(player2X,altoLienzo-altPlayer,anchoPlayer,altPlayer);
  circle(pelotaX,pelotaY,tamPelota);
  fill(255,0,0);
  rect(anchoLienzo/2-redAncho/2,altoLienzo-redAlto,redAncho,redAlto);
  if(pelotaY+tamPelota/2>(altoLienzo-altPlayer)){
    if(pelotaX<anchoLienzo/2){
      if(pelotaX>player1X && pelotaX<(player1X+anchoPlayer)){
        if(player1AntX<player1X){
          pelotaAceleracionX += 10;
        } else if(player1AntX>player1X){
          pelotaAceleracionX -= 10;
        }
        ultimoToque=-1;
        pelotaAceleracionY= -pelotaAceleracionY-fuerzaRebotePala;
      } else {
        addScore(-1);
      }
    } else {
      if(pelotaX>player2X && pelotaX<player2X+anchoPlayer){
        if(player2AntX<player2X){
          pelotaAceleracionX += 4;
        } else if(player2AntX>player2X){
          pelotaAceleracionX -= 4;
        }
        ultimoToque=1;
        pelotaAceleracionY= -pelotaAceleracionY-fuerzaRebotePala;
      } else {
        addScore(1);
      }
    }
  }
  if(pelotaX+tamPelota/2>=(anchoLienzo) || pelotaX-tamPelota/2<=0){
    pelotaAceleracionX = -pelotaAceleracionX;
  }
  if((pelotaX>(anchoLienzo/2-redAncho/2) && pelotaX<(anchoLienzo/2+redAncho/2)) && pelotaY>(altoLienzo-redAlto)){
    addScore(ultimoToque);
  }
  pelotaAceleracionY+=gravedad;
  pelotaY+=pelotaAceleracionY;
  pelotaX+=pelotaAceleracionX;
  println(player1X + " " + player1AntX);
}
