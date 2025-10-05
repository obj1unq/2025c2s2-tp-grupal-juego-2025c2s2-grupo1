object snorlax{
    var property position = game.at(0, 0) 
    var property estado = snorlaxNormal
    var property vidas = 3 //Comienza con 3 vidas
    
    method mover(direccion){
        if (self.puedeMover(direccion)){
            position = direccion.siguiente(self)
        }
    }

    method puedeMover(direccion){
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }

    method comer(){
        if(self.hayAlgoColisionando()){
            self.cambiarEstadoA(snorlaxComiendo)
            game.schedule(500, {self.cambiarEstadoA(snorlaxNormal)})
            game.removeVisual(self.objetoColisinandoConSnorlax())
        }
    }

    method perderUnaVida() { vidas -= 1 }

    method objetoColisinandoConSnorlax() { return game.colliders(self).get(0) }

    method cambiarEstadoA(estadoNuevo) { estado = estadoNuevo }

    method hayAlgoColisionando() { return game.colliders(self).size() > 0 }

    method image() {
        return "snorlax-" + estado.nombre() + ".png"
    }
}

//movimiento del personaje
object izquierda {
    method siguiente(personaje){
        return personaje.position().left(1)
  }
}
object derecha {
  method siguiente(personaje){
    return personaje.position().right(1)
  }
} 

//estados de snorlax
object snorlaxNormal {
    method nombre() {
        return "normal"
    }
}

object snorlaxComiendo {
    method nombre() {
        return "come"
    }
}


// Visualizador de vidas

object vida {
    var property position = game.at(4,9)

    method image() {
        return "icono-" + snorlax.vidas() + "-vidas.png"
    }  
}