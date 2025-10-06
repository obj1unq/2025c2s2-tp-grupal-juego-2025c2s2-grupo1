import personajes.*
import extras.*
object bota {
    var estado = botaAsset1
    var property position = game.at(5, 9)
    var property puntos = -150 

    //acciones
    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

    method aplicarEfecto(personaje) {
        if (snorlax.tieneVidas()) {
            puntuacion.incrementaPuntos(puntos)
            snorlax.perderUnaVida()
            game.schedule(1000, {snorlax.cambiarEstadoA(snorlaxNormal)})
        }
        else {
            snorlax.terminarJuego()
        }
        
    }

    method eliminarDelJuego() {
        game.removeVisual(self)
    }

    //consultas
    method puedeMover(direccion) { return self.hayCelda(direccion) and self.estaEnElJuego()}

    method hayCelda(direccion) {
		return 
			(direccion.siguiente(self).x().between(0, game.width()-1)) and
			(direccion.siguiente(self).y().between(0, game.height()-1))
	}

    method image() {
        return estado.nombre() + ".png"
    }

    method estaEnElJuego() {
        return game.allVisuals().any({ visual => visual == self})
    }

    method estado() { return estado }
}

object botaAsset1 {
    method nombre() { return "bota-1" }
}