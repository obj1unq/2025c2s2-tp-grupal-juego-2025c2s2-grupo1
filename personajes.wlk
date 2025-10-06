import extras.*
object snorlax{
    var property position = game.at(0, 0) 
    var property estado = snorlaxNormal
    var property vidas = 1 //Comienza con 3 vidas
    
    //acciones
    method mover(direccion){
        if (self.puedeMover(direccion)){
            position = direccion.siguiente(self)
        }
    }

    method recibirDaño() {
            self.cambiarEstadoA(snorlaxRecibiendoDaño)
            self.perderUnaVida()
        }

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }

    method terminarJuego() { 
        self.recibirDaño()
        game.schedule(2000, {self.cambiarEstadoA(snorlaxPerdedor)})
        game.schedule(3000, { game.stop() }) 
    }

    method comer(){
        if(self.hayAlgoColisionando()){
            self.cambiarEstadoA(snorlaxComiendo)
            self.objetoColisinandoConSnorlax().aplicarEfecto(self)
            self.objetoColisinandoConSnorlax().eliminarDelJuego()
        }
    }

    method perderUnaVida() { vidas -= 1 }

    method cambiarEstadoA(estadoNuevo) { estado = estadoNuevo }

    //consultas
    method puedeMover(direccion){
        return self.hayCelda(direccion) && !self.tieneVidas()
    }

    method tieneVidas() { return vidas > 1 }

    method objetoColisinandoConSnorlax() { return game.colliders(self).get(0) }

    method hayAlgoColisionando() { return game.colliders(self).size() > 0 }

    method image() {
        return "snorlax-" + estado.nombre() + ".png"
    }
}

//estados de snorlax
object snorlaxNormal {
    method nombre() { return "normal" }
}

object snorlaxComiendo {
    method nombre() { return "come" }
}

object snorlaxRecibiendoDaño {
    method nombre() { return "daño-1" }
}

object snorlaxPerdedor {
    method nombre() { return "perdedor-1" }
}


// Visualizador de vidas

object vida {
    var property position = game.at(4,9)

    method image() {
        return "icono-" + snorlax.vidas() + "-vidas.png"
    }  
}

// puntuacion de snorlax

object puntuacion{
    var property puntos = 0
    var property text = self.puntos().toString()
    var property position = game.at(1,10) 
    method incrementaPuntos(puntosFruta){
        puntos += puntosFruta
        text = self.puntos().toString()
    } 
    method decrementaPuntos(puntosBasura){
        puntos -= puntosBasura
        text = self.puntos().toString()
    }
}