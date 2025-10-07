import personajes.*
import assetsComida.*
import extras.*

//pokelitos

object pokelitoFrutilla {
    var estado = pokelitoFrutillaAsset1 
    var property position = game.at(0, 8)
    const puntos = 150
    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

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

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        puntuacion.incrementaPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
} 

object pokelitoLimon {
    var estado = pokelitoLimonAsset1
    var property position = game.at(1, 8)
    const puntos = 100 

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

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

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        puntuacion.incrementaPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

object pokelitoNaranja {
    var estado = pokelitoNaranjaAsset1
    var property position = game.at(2, 8)
    const puntos = 200 

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

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
        return game.allVisuals().any({ visual => visual == self })
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        puntuacion.incrementaPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

object pokelitoDulceDeLeche {
    var estado = pokelitoDulceDeLecheAsset1
    var property position = game.at(3, 8)
    const puntos = 250 

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

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
        return game.allVisuals().any({ visual => visual == self })
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        puntuacion.incrementaPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

object pokelitoChocolate {
    var estado = pokelitoChocolateAsset1
    var property position = game.at(4, 8)
    const puntos = 250

    method aplicarGravedad() {
        if (self.puedeMover(abajo)) {
            position = abajo.siguiente(self)
        }
        else if (not self.hayCelda(abajo)) {
            game.schedule(1500, {game.removeVisual(self)})
        }
    }

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
        return game.allVisuals().any({ visual => visual == self })
    }

    method estado() { return estado }

    method aplicarEfecto(personaje) {
        game.schedule(500, {snorlax.cambiarEstadoA(snorlaxNormal)})
        puntuacion.incrementaPuntos(puntos)
    }

    method eliminarDelJuego() {
        game.schedule(500, {game.removeVisual(self)})
    }
}

