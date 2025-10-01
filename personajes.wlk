object snorlax{
    var property position = game.at(0, 0) 
    var property iamge = "pepita.png" 
    method estaEnElTablero() {
      return self.position().x().between(0, game.width()-1) 
    }
    method mover(direccion){
        if (self.estaEnElTablero())
        direccion.moverA(self)
    }
}

object izquierda {
  method moverA(pj) {
    pj.position().left(1)
  }
}
object derecha {
  method moverA(pj){
    pj.position().right(1)
  }
}