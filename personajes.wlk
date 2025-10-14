import extras.*
object snorlax{
    var property position = game.at(0, 0) 
    var property estado = snorlaxNormal
    var property vidas = 2 //Comienza con 3 vidas
    
    //acciones
    method mover(direccion){
        if (self.puedeMover(direccion)){
            position = direccion.siguiente(self)
        }
    }

    method recibirDaño() {
        self.objetoColisionandoConSnorlax().aplicarEfecto(self)
        if (self.tieneVidas()) {
            snorlaxRecibiendoDaño.animacion()
        }
        else { self.terminarJuego() }
    }

    method terminarJuego() { 
        snorlaxPerdedor.animacion()
        game.schedule(3000, { game.stop() }) 
    }

    method comer(){
        if(self.hayComidaColisionando()){
            self.objetoColisionandoConSnorlax().aplicarEfecto(self)
        }
    }

    method perderUnaVida() { vidas -= 1 }

    method cambiarEstadoA(estadoNuevo) { estado = estadoNuevo }

    //consultas
    method puedeMover(direccion){
        return self.hayCelda(direccion) && self.tieneVidas()
    }

    method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }

    method tieneVidas() { return vidas > 0 }

    method objetoColisionandoConSnorlax() { return game.colliders(self).get(0) }

    method hayComidaColisionando() { 
        return self.hayAlgoColisionando() && self.objetoColisionandoConSnorlax().esComida() 
    }
 
    method hayAlgoColisionando() { return game.colliders(self).size() > 0 }

    method image() {
        return "snorlax-" + estado.nombre() + ".png"
    }
}

//estados de snorlax
object snorlaxNormal {
    method nombre() { return "normal" }

    method animacion() {}
}

object snorlaxComiendo {
    method nombre() { return "come" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }
}

object snorlaxRecibiendoDaño {
    method nombre() { return "daño-1" }

    method animacion() {
        snorlax.cambiarEstadoA(self)
        game.schedule(1000, {snorlax.cambiarEstadoA(snorlaxNormal)})
    }
}

object snorlaxPerdedor {
    method nombre() { return "perdedor-1" }

    method animacion() {
        snorlax.cambiarEstadoA(snorlaxRecibiendoDaño)
        game.schedule(2000, {snorlax.cambiarEstadoA(self)})
    }
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
    var property position = game.at(1,10) 
    
    method incrementaPuntos(puntosFruta){
        puntos += puntosFruta
    } 

    method text() { return self.puntos().toString() }
}