object snorlax{

    var property position = game.at(0, 0) 
    var property image = "pepita.png" 
    
    method mover(direccion){
        if (self.puedeMover(direccion)){
            direccion.moverA(self)
        }
    }
    method puedeMover(direccion){
        return direccion.siguiente(self).x().between(0, game.width()-1)
    }
}

object izquierda {
  method moverA(pj) {
    pj.position(pj.position().left(1))
  }
  method siguiente(pj){
    return pj.position().left(1)
  }
}
object derecha {
  method moverA(pj){
    pj.position(pj.position().right(1))
  }
  method siguiente(pj){
    return pj.position().right(1)
  }
}

 